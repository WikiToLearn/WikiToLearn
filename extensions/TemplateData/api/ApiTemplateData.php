<?php
/**
 * Implement the 'templatedata' query module in the API.
 * Format JSON only.
 *
 * @file
 */

/**
 * @ingroup API
 * @emits error.code templatedata-corrupt
 * @todo Support continuation (see I1a6e51cd)
 */
class ApiTemplateData extends ApiBase {
	/**
	 * For backwards compatibility, this module needs to output format=json when
	 * no format is specified.
	 * @return ApiFormatBase|null
	 */
	public function getCustomPrinter() {
		if ( $this->getMain()->getVal( 'format' ) === null ) {
			$this->setWarning(
				"The default output format will change to jsonfm in the future." .
				" Please specify format=json explicitly."
			);
			$this->logFeatureUsage( 'action=templatedata&!format' );
			return $this->getMain()->createPrinterByName( 'json' );
		}
		return null;
	}

	/**
	 * @return ApiPageSet
	 */
	private function getPageSet() {
		if ( !isset( $this->mPageSet ) ) {
			$this->mPageSet = new ApiPageSet( $this );
		}
		return $this->mPageSet;
	}

	public function execute() {
		$params = $this->extractRequestParams();
		$result = $this->getResult();

		if ( is_null( $params['lang'] ) ) {
			$langCode = false;
		} elseif ( !Language::isValidCode( $params['lang'] ) ) {
			$this->dieUsage( 'Invalid language code for parameter lang', 'invalidlang' );
		} else {
			$langCode = $params['lang'];
		}

		$pageSet = $this->getPageSet();
		$pageSet->execute();
		$titles = $pageSet->getGoodTitles(); // page_id => Title object

		if ( !count( $titles ) ) {
			$result->addValue( null, 'pages', (object) array() );
			return;
		}

		$db = $this->getDB();
		$res = $db->select( 'page_props',
			array( 'pp_page', 'pp_value' ), array(
				'pp_page' => array_keys( $titles ),
				'pp_propname' => 'templatedata'
			),
			__METHOD__,
			array( 'ORDER BY', 'pp_page' )
		);

		$resp = array();

		foreach ( $res as $row ) {
			$rawData = $row->pp_value;
			$tdb = TemplateDataBlob::newFromDatabase( $rawData );
			$status = $tdb->getStatus();

			if ( !$status->isOK() ) {
				$this->dieUsage(
					'Page #' . intval( $row->pp_page ) . ' templatedata contains invalid data: '
						. $status->getMessage(), 'templatedata-corrupt'
				);
			}

			if ( $langCode ) {
				$data = $tdb->getDataInLanguage( $langCode );
			} else {
				$data = $tdb->getData();
			}

			// HACK: don't let ApiResult's formatversion=1 compatibility layer mangle our booleans
			// to empty strings / absent properties
			if ( defined( 'ApiResult::META_BC_BOOLS' ) ) {
				foreach ( $data->params as &$param ) {
					$param->{ApiResult::META_BC_BOOLS} = array( 'required', 'suggested', 'deprecated' );
				}
				unset( $param );

				$data->params->{ApiResult::META_TYPE} = 'kvp';
				$data->params->{ApiResult::META_KVP_KEY_NAME} = 'key';
				$data->params->{ApiResult::META_INDEXED_TAG_NAME} = 'param';
				ApiResult::setIndexedTagName( $data->paramOrder, 'p' );
			}

			$resp[$row->pp_page] = array(
				'title' => strval( $titles[$row->pp_page] ),
			) + (array) $data;
		}

		ApiResult::setArrayType( $resp, 'kvp', 'id' );
		ApiResult::setIndexedTagName( $resp, 'page' );

		// Set top level element
		$result->addValue( null, 'pages', (object) $resp );

		$values = $pageSet->getNormalizedTitlesAsResult();
		if ( $values ) {
			$result->addValue( null, 'normalized', $values );
		}
		$redirects = $pageSet->getRedirectTitlesAsResult();
		if ( $redirects ) {
			$result->addValue( null, 'redirects', $redirects );
		}
	}

	public function getAllowedParams( $flags = 0 ) {
		return $this->getPageSet()->getFinalParams( $flags ) + array(
			'lang' => null
		);
	}

	/**
	 * @see ApiBase::getExamplesMessages()
	 */
	protected function getExamplesMessages() {
		return array(
			'action=templatedata&titles=Template:Stub|Template:Example'
				=> 'apihelp-templatedata-example-1',
		);
	}

	public function getHelpUrls() {
		return 'https://www.mediawiki.org/wiki/Extension:TemplateData';
	}
}
