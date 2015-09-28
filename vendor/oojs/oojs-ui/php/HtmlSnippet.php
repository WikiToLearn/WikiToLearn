<?php

namespace OOUI;

/**
 * Wraps a HTML snippet for use with Tag::appendContent() and Tag::prependContent().
 */
class HtmlSnippet {

	/* Members */

	/**
	 * HTML snippet this instance represents.
	 *
	 * @var string
	 */
	protected $content;

	/* Methods */

	/**
	 * @param string $content
	 */
	public function __construct( $content ) {
		$this->content = $content;
	}

	/**
	 * Render into HTML.
	 *
	 * @return string Unchanged HTML snippet
	 */
	public function __toString() {
		return $this->content;
	}
}
