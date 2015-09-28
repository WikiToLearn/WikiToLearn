<?php

namespace Liuggio\StatsdClient\Entity;

use Liuggio\StatsdClient\Entity\StatsdDataInterface;

class StatsdData implements StatsdDataInterface
{

    private $key;
    private $value;
    private $metric;

    /**
     * @param string $key
     */
    public function setKey($key)
    {
        $this->key = $key;
    }

    /**
     * @return string
     */
    public function getKey()
    {
        return $this->key;
    }

    /**
     * @param int $value
     */
    public function setValue($value)
    {
        $this->value = $value;
    }

    /**
     * @return int
     */
    public function getValue()
    {
        return $this->value;
    }


    public function setMetric($metric)
    {
        $this->metric = $metric;
    }

    public function getMetric()
    {
        return $this->metric;
    }

    /**
     * @param bool $withMetric
     *
     * @return string
     */
    public function getMessage($withMetric = true)
    {
        if (!$withMetric) {
            return sprintf('%s:%s', $this->getKey(), $this->getValue());
        } else {
            return sprintf('%s:%s|%s', $this->getKey(), $this->getValue(), $this->getMetric());
        }
    }

    /**
     * @return string
     */
    public function __toString()
    {
        return $this->getMessage();
    }
}
