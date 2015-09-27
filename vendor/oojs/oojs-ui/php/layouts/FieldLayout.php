<?php

namespace OOUI;

/**
 * Layout made of a field and optional label.
 *
 * Available label alignment modes include:
 *  - left: Label is before the field and aligned away from it, best for when the user will be
 *    scanning for a specific label in a form with many fields
 *  - right: Label is before the field and aligned toward it, best for forms the user is very
 *    familiar with and will tab through field checking quickly to verify which field they are in
 *  - top: Label is before the field and above it, best for when the user will need to fill out all
 *    fields from top to bottom in a form with few fields
 *  - inline: Label is after the field and aligned toward it, best for small boolean fields like
 *    checkboxes or radio buttons
 */
class FieldLayout extends Layout {

	/**
	 * Alignment.
	 *
	 * @var string
	 */
	protected $align;

	/**
	 * Field widget to be laid out.
	 *
	 * @var Widget
	 */
	protected $fieldWidget;

	private $field, $body, $help;

	/**
	 * @param Widget $fieldWidget Field widget
	 * @param array $config Configuration options
	 * @param string $config['align'] Alignment mode, either 'left', 'right', 'top' or 'inline'
	 *   (default: 'left')
	 * @param string $config['help'] Explanatory text shown as a '?' icon.
	 */
	public function __construct( $fieldWidget, array $config = array() ) {
		// Allow passing positional parameters inside the config array
		if ( is_array( $fieldWidget ) && isset( $fieldWidget['fieldWidget'] ) ) {
			$config = $fieldWidget;
			$fieldWidget = $config['fieldWidget'];
		}

		$hasInputWidget = $fieldWidget instanceof InputWidget;

		// Config initialization
		$config = array_merge( array( 'align' => 'left' ), $config );

		// Parent constructor
		parent::__construct( $config );

		// Properties
		$this->fieldWidget = $fieldWidget;
		$this->field = new Tag( 'div' );
		$this->body = new Tag( $hasInputWidget ? 'label' : 'div' );
		if ( isset( $config['help'] ) ) {
			$this->help = new ButtonWidget( array(
				'classes' => array( 'oo-ui-fieldLayout-help' ),
				'framed' => false,
				'icon' => 'info',
				'title' => $config['help'],
			) );
		} else {
			$this->help = '';
		}

		// Mixins
		$this->mixin( new LabelElement( $this, $config ) );

		// Initialization
		$this
			->addClasses( array( 'oo-ui-fieldLayout' ) )
			->appendContent( $this->help, $this->body );
		$this->body->addClasses( array( 'oo-ui-fieldLayout-body' ) );
		$this->field
			->addClasses( array( 'oo-ui-fieldLayout-field' ) )
			->toggleClasses( array( 'oo-ui-fieldLayout-disable' ), $this->fieldWidget->isDisabled() )
			->appendContent( $this->fieldWidget );

		$this->setAlignment( $config['align'] );
	}

	/**
	 * Get the field.
	 *
	 * @return Widget Field widget
	 */
	public function getField() {
		return $this->fieldWidget;
	}

	/**
	 * Set the field alignment mode.
	 *
	 * @param string $value Alignment mode, either 'left', 'right', 'top' or 'inline'
	 * @chainable
	 */
	protected function setAlignment( $value ) {
		if ( $value !== $this->align ) {
			// Default to 'left'
			if ( !in_array( $value, array( 'left', 'right', 'top', 'inline' ) ) ) {
				$value = 'left';
			}
			// Reorder elements
			$this->body->clearContent();
			if ( $value === 'inline' ) {
				$this->body->appendContent( $this->field, $this->label );
			} else {
				$this->body->appendContent( $this->label, $this->field );
			}
			// Set classes. The following classes can be used here:
			// * oo-ui-fieldLayout-align-left
			// * oo-ui-fieldLayout-align-right
			// * oo-ui-fieldLayout-align-top
			// * oo-ui-fieldLayout-align-inline
			if ( $this->align ) {
				$this->removeClasses( array( 'oo-ui-fieldLayout-align-' . $this->align ) );
			}
			$this->addClasses( array( 'oo-ui-fieldLayout-align-' . $value ) );
			$this->align = $value;
		}

		return $this;
	}

	public function getConfig( &$config ) {
		$config['fieldWidget'] = $this->fieldWidget;
		$config['align'] = $this->align;
		if ( $this->help !== '' ) {
			$config['help'] = $this->help->getTitle();
		}
		return parent::getConfig( $config );
	}
}
