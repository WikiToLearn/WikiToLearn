<?php

namespace Cdb\Test;
use Cdb\Reader;
use Cdb\Writer;

/**
 * Test the CDB reader/writer
 * @covers Cdb\Writer\PHP
 * @covers Cdb\Writer\DBA
 */
class CdbTest extends \PHPUnit_Framework_TestCase {
	/** @var string */
	private $phpCdbFile, $dbaCdbFile;

	protected function setUp() {
		parent::setUp();
		if ( !Reader::haveExtension() ) {
			$this->markTestSkipped( 'Native CDB support is not available.' );
		}
		$temp = sys_get_temp_dir();
		if ( !is_writable( $temp ) ) {
			$this->markTestSkipped( "Temp dir [$temp] isn't writable." );
		}
		$this->phpCdbFile = tempnam( $temp, get_class( $this ) . '_' );
		$this->dbaCdbFile = tempnam( $temp, get_class( $this ) . '_' );
	}

	/**
	 * Make a random-ish string
	 * @return string
	 */
	private static function randomString() {
		$len = mt_rand( 0, 10 );
		$s = '';
		for ( $j = 0; $j < $len; $j++ ) {
			$s .= chr( mt_rand( 0, 255 ) );
		}

		return $s;
	}

	public function testCdbWrite() {
		$w1 = new Writer\PHP( $this->phpCdbFile );
		$w2 = new Writer\DBA( $this->dbaCdbFile );

		$data = array();
		for ( $i = 0; $i < 1000; $i++ ) {
			$key = self::randomString();
			$value = self::randomString();
			$w1->set( $key, $value );
			$w2->set( $key, $value );

			if ( !isset( $data[$key] ) ) {
				$data[$key] = $value;
			}
		}

		$w1->close();
		$w2->close();

		$this->assertEquals(
			md5_file( $this->phpCdbFile ),
			md5_file( $this->dbaCdbFile ),
			'same hash'
		);

		$r1 = new Reader\PHP( $this->phpCdbFile );
		$r2 = new Reader\DBA( $this->dbaCdbFile );

		foreach ( $data as $key => $value ) {
			if ( $key === '' ) {
				// Known bug
				continue;
			}
			$v1 = $r1->get( $key );
			$v2 = $r2->get( $key );

			$v1 = $v1 === false ? '(not found)' : $v1;
			$v2 = $v2 === false ? '(not found)' : $v2;

			# cdbAssert( 'Mismatch', $key, $v1, $v2 );
			$this->cdbAssert( "PHP error", $key, $v1, $value );
			$this->cdbAssert( "DBA error", $key, $v2, $value );
		}
	}

	private function cdbAssert( $msg, $key, $v1, $v2 ) {
		$this->assertEquals(
			$v2,
			$v1,
			$msg . ', k=' . bin2hex( $key )
		);
	}
}
