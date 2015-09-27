<?php

namespace OOUI;

/**
 * Element with a button.
 *
 * Buttons are used for controls which can be clicked. They can be configured to use tab indexing
 * and access keys for accessibility purposes.
 *
 * @abstract
 */
class ButtonElement extends ElementMixin {
	/**
	 * Button is framed.
	 *
	 * @var boolean
	 */
	protected $framed = false;

	/**
	 * Button's access key.
	 *
	 * @var string
	 */
	protected $accessKey = null;

	public static $targetPropertyName = 'button';

	/**
	 * @param Element $element Element being mixed into
	 * @param array $config Configuration options
	 * @param boolean $config['framed'] Render button with a frame (default: true)
	 * @param string $config['accessKey'] Button's access key
	 */
	public function __construct( Element $element, array $config = array() ) {
		// Parent constructor
		$target = isset( $config['button'] ) ? $config['button'] : new Tag( 'a' );
		parent::__construct( $element, $target, $config );

		// Initialization
		$this->element->addClasses( array( 'oo-ui-buttonElement' ) );
		$this->target->addClasses( array( 'oo-ui-buttonElement-button' ) );
		$this->toggleFramed( isset( $config['framed'] ) ? $config['framed'] : true );
		$this->setAccessKey( isset( $config['accessKey'] ) ? $config['accessKey'] : null );
		$this->target->setAttributes( array(
			'role' => 'button',
		) );
	}

	/**
	 * Toggle frame.
	 *
	 * @param boolean $framed Make button framed, omit to toggle
	 * @chainable
	 */
	public function toggleFramed( $framed = null ) {
		$this->framed = $framed !== null ? !!$framed : !$this->framed;
		$this->element->toggleClasses( array( 'oo-ui-buttonElement-framed' ), $this->framed );
		$this->element->toggleClasses( array( 'oo-ui-buttonElement-frameless' ), !$this->framed );
	}

	/**
	 * Check if button has a frame.
	 *
	 * @return boolean Button is framed
	 */
	public function isFramed() {
		return $this->framed;
	}

	/**
	 * Set access key.
	 *
	 * @param string $accessKey Button's access key, use empty string to remove
	 * @chainable
	 */
	public function setAccessKey( $accessKey ) {
		$accessKey = is_string( $accessKey ) && strlen( $accessKey ) ? $accessKey : null;

		if ( $this->accessKey !== $accessKey ) {
			if ( $accessKey !== null ) {
				$this->target->setAttributes( array( 'accesskey' => $accessKey ) );
			} else {
				$this->target->removeAttributes( array( 'accesskey' ) );
			}
			$this->accessKey = $accessKey;
		}

		return $this;
	}

	public function getConfig( &$config ) {
		if ( $this->framed !== true ) {
			$config['framed'] = $this->framed;
		}
		if ( $this->accessKey !== null ) {
			$config['accessKey'] = $this->accessKey;
		}
		return parent::getConfig( $config );
	}
}
