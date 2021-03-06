<?php
/**
 * Weekly.
 *
 * @copyright Ralf Koester (Koester)
 * @license http://www.gnu.org/licenses/lgpl.html GNU Lesser General Public License
 * @package Weekly
 * @author Ralf Koester <ralf@familie-koester.de>.
 * @link http://zikula.de
 * @link http://zikula.org
 * @version Generated by ModuleStudio 0.6.1 (http://modulestudio.de).
 */

/**
 * Validator class for encapsulating entity validation methods.
 *
 * This is the base validation class for event entities.
 */
class Weekly_Entity_Validator_Base_Event extends Weekly_Validator
{
    /**
     * Performs all validation rules.
     *
     * @return mixed either array with error information or true on success
     */
    public function validateAll()
    {
        $errorInfo = array('message' => '', 'code' => 0, 'debugArray' => array());
        $dom = ZLanguage::getModuleDomain('Weekly');
        if (!$this->isStringNotEmpty('workflowState')) {
            $errorInfo['message'] = __f('Error! Field value must not be empty (%s).', array('workflow state'), $dom);
            return $errorInfo;
        }
        if (!$this->isStringNotLongerThan('eventName', 255)) {
            $errorInfo['message'] = __f('Error! Length of field value must not be higher than %2$s (%1$s).', array('event name', 255), $dom);
            return $errorInfo;
        }
        if (!$this->isStringNotEmpty('eventName')) {
            $errorInfo['message'] = __f('Error! Field value must not be empty (%s).', array('event name'), $dom);
            return $errorInfo;
        }
        if (!$this->isStringNotEmpty('eventDay')) {
            $errorInfo['message'] = __f('Error! Field value must not be empty (%s).', array('event day'), $dom);
            return $errorInfo;
        }
        if (!$this->isStringNotLongerThan('eventBeginText', 5)) {
            $errorInfo['message'] = __f('Error! Length of field value must not be higher than %2$s (%1$s).', array('event begin text', 5), $dom);
            return $errorInfo;
        }
        if (!$this->isStringNotEmpty('eventBeginText')) {
            $errorInfo['message'] = __f('Error! Field value must not be empty (%s).', array('event begin text'), $dom);
            return $errorInfo;
        }
        if (!$this->isStringNotShorterThan('eventBeginText', 5)) {
            $errorInfo['message'] = __f('Error! Length of field value must not be smaller than %2$s (%1$s).', array('event begin text', 5), $dom);
            return $errorInfo;
        }
        if (!$this->isValidRegExp('eventBeginText', '/^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$/')) {
            $errorInfo['message'] = __f('Error! Field value must conform to regular expression [%2$s] (%1$s).', array('event begin text', '/^([0-9]|0[0-9]|1[0-9]|2[0-3]):[0-5][0-9]$/'), $dom);
            return $errorInfo;
        }
        if (!$this->isStringWithFixedLength('eventBeginText', 5)) {
            $errorInfo['message'] = __f('Error! Length of field value must be %2$s (%1$s).', array('event begin text', 5), $dom);
            return $errorInfo;
        }
        if (!$this->isValidInteger('eventDuration')) {
            $errorInfo['message'] = __f('Error! Field value may only contain digits (%s).', array('event duration'), $dom);
            return $errorInfo;
        }
        if (!$this->isNumberNotEmpty('eventDuration')) {
            $errorInfo['message'] = __f('Error! Field value must not be 0 (%s).', array('event duration'), $dom);
            return $errorInfo;
        }
        if (!$this->isNumberNotLongerThan('eventDuration', 11)) {
            $errorInfo['message'] = __f('Error! Length of field value must not be higher than %2$s (%1$s).', array('event duration', 11), $dom);
            return $errorInfo;
        }
        if (!$this->isStringNotLongerThan('eventMessage', 255)) {
            $errorInfo['message'] = __f('Error! Length of field value must not be higher than %2$s (%1$s).', array('event message', 255), $dom);
            return $errorInfo;
        }
        if (!$this->isStringNotLongerThan('eventText', 2000)) {
            $errorInfo['message'] = __f('Error! Length of field value must not be higher than %2$s (%1$s).', array('event text', 2000), $dom);
            return $errorInfo;
        }
        if (!$this->isValidInteger('maxParticipants')) {
            $errorInfo['message'] = __f('Error! Field value may only contain digits (%s).', array('max participants'), $dom);
            return $errorInfo;
        }
        if (!$this->isNumberNotLongerThan('maxParticipants', 11)) {
            $errorInfo['message'] = __f('Error! Length of field value must not be higher than %2$s (%1$s).', array('max participants', 11), $dom);
            return $errorInfo;
        }
        if (!$this->isValidInteger('currentParticipants')) {
            $errorInfo['message'] = __f('Error! Field value may only contain digits (%s).', array('current participants'), $dom);
            return $errorInfo;
        }
        if (!$this->isNumberNotLongerThan('currentParticipants', 11)) {
            $errorInfo['message'] = __f('Error! Length of field value must not be higher than %2$s (%1$s).', array('current participants', 11), $dom);
            return $errorInfo;
        }
        if (!$this->isValidBoolean('active')) {
            $errorInfo['message'] = __f('Error! Field value must be a valid boolean (%s).', array('active'), $dom);
            return $errorInfo;
        }
    
        return true;
    }
    
    /**
     * Check for unique values.
     *
     * This method determines if there already exist events with the same event.
     *
     * @param string $fieldName The name of the property to be checked
     * @return boolean result of this check, true if the given event does not already exist
     */
    public function isUniqueValue($fieldName)
    {
        if ($this->entity[$fieldName] == '') {
            return false;
        }
    
        $entityClass = 'Weekly_Entity_Event';
        $serviceManager = ServiceUtil::getManager();
        $entityManager = $serviceManager->getService('doctrine.entitymanager');
        $repository = $entityManager->getRepository($entityClass);
    
        $excludeid = $this->entity['id'];
    
        return $repository->detectUniqueState($fieldName, $this->entity[$fieldName], $excludeid);
    }
    
    /**
     * Get entity.
     *
     * @return Zikula_EntityAccess
     */
    public function getEntity()
    {
        return $this->entity;
    }
    
    /**
     * Set entity.
     *
     * @param Zikula_EntityAccess $entity.
     *
     * @return void
     */
    public function setEntity(Zikula_EntityAccess $entity = null)
    {
        $this->entity = $entity;
    }
    
}
