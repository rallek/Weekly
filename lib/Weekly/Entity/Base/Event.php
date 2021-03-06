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

use Doctrine\ORM\Mapping as ORM;
use Gedmo\Mapping\Annotation as Gedmo;
use DoctrineExtensions\StandardFields\Mapping\Annotation as ZK;

/**
 * Entity class that defines the entity structure and behaviours.
 *
 * This is the base entity class for event entities.
 *
 * @abstract
 */
abstract class Weekly_Entity_Base_Event extends Zikula_EntityAccess
{
    /**
     * @var string The tablename this object maps to.
     */
    protected $_objectType = 'event';
    
    /**
     * @var Weekly_Entity_Validator_Event The validator for this entity.
     */
    protected $_validator = null;
    
    /**
     * @var boolean Option to bypass validation if needed.
     */
    protected $_bypassValidation = false;
    
    /**
     * @var array List of available item actions.
     */
    protected $_actions = array();
    
    /**
     * @var array The current workflow data of this object.
     */
    protected $__WORKFLOW__ = array();
    
    /**
     * @ORM\Id
     * @ORM\GeneratedValue(strategy="AUTO")
     * @ORM\Column(type="integer", unique=true)
     * @var integer $id.
     */
    protected $id = 0;
    
    /**
     * @ORM\Column(length=20)
     * @var string $workflowState.
     */
    protected $workflowState = 'initial';
    
    /**
     * @ORM\Column(type="datetime")
     * @var DateTime $eventBegin.
     */
    protected $eventBegin = null;
    
    /**
     * @ORM\Column(length=255)
     * @var string $eventName.
     */
    protected $eventName = '';
    
    /**
     * @ORM\Column(length=255)
     * @var string $eventDay.
     */
    protected $eventDay = null;
    
    /**
     * @ORM\Column(length=5)
     * @var string $eventBeginText.
     */
    protected $eventBeginText = '00:00';
    
    /**
     * @ORM\Column(type="bigint")
     * @var integer $eventDuration.
     */
    protected $eventDuration = 60;
    
    /**
     * @ORM\Column(length=255)
     * @var string $eventMessage.
     */
    protected $eventMessage = '';
    
    /**
     * @ORM\Column(type="text", length=2000)
     * @var text $eventText.
     */
    protected $eventText = '';
    
    /**
     * @ORM\Column(type="bigint")
     * @var integer $maxParticipants.
     */
    protected $maxParticipants = 4;
    
    /**
     * @ORM\Column(type="bigint")
     * @var integer $currentParticipants.
     */
    protected $currentParticipants = 0;
    
    /**
     * @ORM\Column(type="boolean")
     * @var boolean $active.
     */
    protected $active = true;
    
    
    /**
     * @ORM\Column(type="integer")
     * @ZK\StandardFields(type="userid", on="create")
     * @var integer $createdUserId.
     */
    protected $createdUserId;
    
    /**
     * @ORM\Column(type="integer")
     * @ZK\StandardFields(type="userid", on="update")
     * @var integer $updatedUserId.
     */
    protected $updatedUserId;
    
    /**
     * @ORM\Column(type="datetime")
     * @Gedmo\Timestampable(on="create")
     * @var datetime $createdDate.
     */
    protected $createdDate;
    
    /**
     * @ORM\Column(type="datetime")
     * @Gedmo\Timestampable(on="update")
     * @var datetime $updatedDate.
     */
    protected $updatedDate;
    
    /**
     * Bidirectional - Many event [events] are linked by one kind [kind] (OWNING SIDE).
     *
     * @ORM\ManyToOne(targetEntity="Weekly_Entity_Kind", inversedBy="event", cascade={"persist"})
     * @ORM\JoinTable(name="weekly_kind")
     * @var Weekly_Entity_Kind $kind.
     */
    protected $kind;
    
    /**
     * Bidirectional - Many event [events] are linked by one location [location] (OWNING SIDE).
     *
     * @ORM\ManyToOne(targetEntity="Weekly_Entity_Location", inversedBy="event", cascade={"persist"})
     * @ORM\JoinTable(name="weekly_location")
     * @var Weekly_Entity_Location $location.
     */
    protected $location;
    
    /**
     * Bidirectional - Many event [events] are linked by one manager [manager] (OWNING SIDE).
     *
     * @ORM\ManyToOne(targetEntity="Weekly_Entity_Manager", inversedBy="event", cascade={"persist"})
     * @ORM\JoinTable(name="weekly_manager")
     * @var Weekly_Entity_Manager $manager.
     */
    protected $manager;
    
    /**
     * Bidirectional - Many event [events] are linked by one comanager [comanager] (OWNING SIDE).
     *
     * @ORM\ManyToOne(targetEntity="Weekly_Entity_Comanager", inversedBy="event", cascade={"persist"})
     * @ORM\JoinTable(name="weekly_comanager")
     * @var Weekly_Entity_Comanager $comanager.
     */
    protected $comanager;
    
    
    /**
     * Constructor.
     * Will not be called by Doctrine and can therefore be used
     * for own implementation purposes. It is also possible to add
     * arbitrary arguments as with every other class method.
     *
     * @param TODO
     */
    public function __construct()
    {
        
        $serviceManager = ServiceUtil::getManager();
        $listHelper = new Weekly_Util_ListEntries($serviceManager);
        
        $items = array();
        $listEntries = $listHelper->getEventDayEntriesForEvent();
        foreach ($listEntries as $listEntry) {
            if ($listEntry['default'] === true) {
                $items[] = $listEntry['value'];
            }
        }
        $this->eventDay = implode('###', $items);
        
        $this->workflowState = 'initial';
        $this->initValidator();
        $this->initWorkflow();
    }
    
    /**
     * Get _object type.
     *
     * @return string
     */
    public function get_objectType()
    {
        return $this->_objectType;
    }
    
    /**
     * Set _object type.
     *
     * @param string $_objectType.
     *
     * @return void
     */
    public function set_objectType($_objectType)
    {
        $this->_objectType = $_objectType;
    }
    
    /**
     * Get _validator.
     *
     * @return Weekly_Entity_Validator_Event
     */
    public function get_validator()
    {
        return $this->_validator;
    }
    
    /**
     * Set _validator.
     *
     * @param Weekly_Entity_Validator_Event $_validator.
     *
     * @return void
     */
    public function set_validator(Weekly_Entity_Validator_Event $_validator = null)
    {
        $this->_validator = $_validator;
    }
    
    /**
     * Get _bypass validation.
     *
     * @return boolean
     */
    public function get_bypassValidation()
    {
        return $this->_bypassValidation;
    }
    
    /**
     * Set _bypass validation.
     *
     * @param boolean $_bypassValidation.
     *
     * @return void
     */
    public function set_bypassValidation($_bypassValidation)
    {
        $this->_bypassValidation = $_bypassValidation;
    }
    
    /**
     * Get _actions.
     *
     * @return array
     */
    public function get_actions()
    {
        return $this->_actions;
    }
    
    /**
     * Set _actions.
     *
     * @param array $_actions.
     *
     * @return void
     */
    public function set_actions(array $_actions = Array())
    {
        $this->_actions = $_actions;
    }
    
    /**
     * Get __ w o r k f l o w__.
     *
     * @return array
     */
    public function get__WORKFLOW__()
    {
        return $this->__WORKFLOW__;
    }
    
    /**
     * Set __ w o r k f l o w__.
     *
     * @param array $__WORKFLOW__.
     *
     * @return void
     */
    public function set__WORKFLOW__(array $__WORKFLOW__ = Array())
    {
        $this->__WORKFLOW__ = $__WORKFLOW__;
    }
    
    
    /**
     * Get id.
     *
     * @return integer
     */
    public function getId()
    {
        return $this->id;
    }
    
    /**
     * Set id.
     *
     * @param integer $id.
     *
     * @return void
     */
    public function setId($id)
    {
        if ($id != $this->id) {
            $this->id = $id;
        }
    }
    
    /**
     * Get workflow state.
     *
     * @return string
     */
    public function getWorkflowState()
    {
        return $this->workflowState;
    }
    
    /**
     * Set workflow state.
     *
     * @param string $workflowState.
     *
     * @return void
     */
    public function setWorkflowState($workflowState)
    {
        if ($workflowState != $this->workflowState) {
            $this->workflowState = $workflowState;
        }
    }
    
    /**
     * Get event begin.
     *
     * @return DateTime
     */
    public function getEventBegin()
    {
        return $this->eventBegin;
    }
    
    /**
     * Set event begin.
     *
     * @param DateTime $eventBegin.
     *
     * @return void
     */
    public function setEventBegin($eventBegin)
    {
        if ($eventBegin != $this->eventBegin) {
            if (is_object($eventBegin) && $eventBegin instanceOf \DateTime) {
                $this->eventBegin = $eventBegin;
            } else {
                $this->eventBegin = new \DateTime($eventBegin);
            }
        }
    }
    
    /**
     * Get event name.
     *
     * @return string
     */
    public function getEventName()
    {
        return $this->eventName;
    }
    
    /**
     * Set event name.
     *
     * @param string $eventName.
     *
     * @return void
     */
    public function setEventName($eventName)
    {
        if ($eventName != $this->eventName) {
            $this->eventName = $eventName;
        }
    }
    
    /**
     * Get event day.
     *
     * @return string
     */
    public function getEventDay()
    {
        return $this->eventDay;
    }
    
    /**
     * Set event day.
     *
     * @param string $eventDay.
     *
     * @return void
     */
    public function setEventDay($eventDay)
    {
        if ($eventDay != $this->eventDay) {
            $this->eventDay = $eventDay;
        }
    }
    
    /**
     * Get event begin text.
     *
     * @return string
     */
    public function getEventBeginText()
    {
        return $this->eventBeginText;
    }
    
    /**
     * Set event begin text.
     *
     * @param string $eventBeginText.
     *
     * @return void
     */
    public function setEventBeginText($eventBeginText)
    {
        if ($eventBeginText != $this->eventBeginText) {
            $this->eventBeginText = $eventBeginText;
        }
    }
    
    /**
     * Get event duration.
     *
     * @return bigint
     */
    public function getEventDuration()
    {
        return $this->eventDuration;
    }
    
    /**
     * Set event duration.
     *
     * @param bigint $eventDuration.
     *
     * @return void
     */
    public function setEventDuration($eventDuration)
    {
        if ($eventDuration != $this->eventDuration) {
            $this->eventDuration = $eventDuration;
        }
    }
    
    /**
     * Get event message.
     *
     * @return string
     */
    public function getEventMessage()
    {
        return $this->eventMessage;
    }
    
    /**
     * Set event message.
     *
     * @param string $eventMessage.
     *
     * @return void
     */
    public function setEventMessage($eventMessage)
    {
        if ($eventMessage != $this->eventMessage) {
            $this->eventMessage = $eventMessage;
        }
    }
    
    /**
     * Get event text.
     *
     * @return text
     */
    public function getEventText()
    {
        return $this->eventText;
    }
    
    /**
     * Set event text.
     *
     * @param text $eventText.
     *
     * @return void
     */
    public function setEventText($eventText)
    {
        if ($eventText != $this->eventText) {
            $this->eventText = $eventText;
        }
    }
    
    /**
     * Get max participants.
     *
     * @return bigint
     */
    public function getMaxParticipants()
    {
        return $this->maxParticipants;
    }
    
    /**
     * Set max participants.
     *
     * @param bigint $maxParticipants.
     *
     * @return void
     */
    public function setMaxParticipants($maxParticipants)
    {
        if ($maxParticipants != $this->maxParticipants) {
            $this->maxParticipants = $maxParticipants;
        }
    }
    
    /**
     * Get current participants.
     *
     * @return bigint
     */
    public function getCurrentParticipants()
    {
        return $this->currentParticipants;
    }
    
    /**
     * Set current participants.
     *
     * @param bigint $currentParticipants.
     *
     * @return void
     */
    public function setCurrentParticipants($currentParticipants)
    {
        if ($currentParticipants != $this->currentParticipants) {
            $this->currentParticipants = $currentParticipants;
        }
    }
    
    /**
     * Get active.
     *
     * @return boolean
     */
    public function getActive()
    {
        return $this->active;
    }
    
    /**
     * Set active.
     *
     * @param boolean $active.
     *
     * @return void
     */
    public function setActive($active)
    {
        if ($active !== $this->active) {
            $this->active = (bool)$active;
        }
    }
    
    /**
     * Get created user id.
     *
     * @return integer
     */
    public function getCreatedUserId()
    {
        return $this->createdUserId;
    }
    
    /**
     * Set created user id.
     *
     * @param integer $createdUserId.
     *
     * @return void
     */
    public function setCreatedUserId($createdUserId)
    {
        $this->createdUserId = $createdUserId;
    }
    
    /**
     * Get updated user id.
     *
     * @return integer
     */
    public function getUpdatedUserId()
    {
        return $this->updatedUserId;
    }
    
    /**
     * Set updated user id.
     *
     * @param integer $updatedUserId.
     *
     * @return void
     */
    public function setUpdatedUserId($updatedUserId)
    {
        $this->updatedUserId = $updatedUserId;
    }
    
    /**
     * Get created date.
     *
     * @return datetime
     */
    public function getCreatedDate()
    {
        return $this->createdDate;
    }
    
    /**
     * Set created date.
     *
     * @param datetime $createdDate.
     *
     * @return void
     */
    public function setCreatedDate($createdDate)
    {
        $this->createdDate = $createdDate;
    }
    
    /**
     * Get updated date.
     *
     * @return datetime
     */
    public function getUpdatedDate()
    {
        return $this->updatedDate;
    }
    
    /**
     * Set updated date.
     *
     * @param datetime $updatedDate.
     *
     * @return void
     */
    public function setUpdatedDate($updatedDate)
    {
        $this->updatedDate = $updatedDate;
    }
    
    
    /**
     * Get kind.
     *
     * @return Weekly_Entity_Kind
     */
    public function getKind()
    {
        return $this->kind;
    }
    
    /**
     * Set kind.
     *
     * @param Weekly_Entity_Kind $kind.
     *
     * @return void
     */
    public function setKind(Weekly_Entity_Kind $kind = null)
    {
        $this->kind = $kind;
    }
    
    /**
     * Get location.
     *
     * @return Weekly_Entity_Location
     */
    public function getLocation()
    {
        return $this->location;
    }
    
    /**
     * Set location.
     *
     * @param Weekly_Entity_Location $location.
     *
     * @return void
     */
    public function setLocation(Weekly_Entity_Location $location = null)
    {
        $this->location = $location;
    }
    
    /**
     * Get manager.
     *
     * @return Weekly_Entity_Manager
     */
    public function getManager()
    {
        return $this->manager;
    }
    
    /**
     * Set manager.
     *
     * @param Weekly_Entity_Manager $manager.
     *
     * @return void
     */
    public function setManager(Weekly_Entity_Manager $manager = null)
    {
        $this->manager = $manager;
    }
    
    /**
     * Get comanager.
     *
     * @return Weekly_Entity_Comanager
     */
    public function getComanager()
    {
        return $this->comanager;
    }
    
    /**
     * Set comanager.
     *
     * @param Weekly_Entity_Comanager $comanager.
     *
     * @return void
     */
    public function setComanager(Weekly_Entity_Comanager $comanager = null)
    {
        $this->comanager = $comanager;
    }
    
    
    /**
     * Initialise validator and return it's instance.
     *
     * @return Weekly_Entity_Validator_Event The validator for this entity.
     */
    public function initValidator()
    {
        if (!is_null($this->_validator)) {
            return $this->_validator;
        }
        $this->_validator = new Weekly_Entity_Validator_Event($this);
    
        return $this->_validator;
    }
    
    /**
     * Sets/retrieves the workflow details.
     */
    public function initWorkflow()
    {
        $currentFunc = FormUtil::getPassedValue('func', 'main', 'GETPOST', FILTER_SANITIZE_STRING);
        $isReuse = FormUtil::getPassedValue('astemplate', '', 'GETPOST', FILTER_SANITIZE_STRING);
    
        // apply workflow with most important information
        $idColumn = 'id';
        $workflowHelper = new Weekly_Util_Workflow(ServiceUtil::getManager());
        $schemaName = $workflowHelper->getWorkflowName($this['_objectType']);
        $this['__WORKFLOW__'] = array(
            'state' => $this['workflowState'],
            'obj_table' => $this['_objectType'],
            'obj_idcolumn' => $idColumn,
            'obj_id' => $this[$idColumn],
            'schemaname' => $schemaName);
        
        // load the real workflow only when required (e. g. when func is edit or delete)
        if (!in_array($currentFunc, array('main', 'view', 'display')) && empty($isReuse)) {
            $result = Zikula_Workflow_Util::getWorkflowForObject($this, $this['_objectType'], $idColumn, 'Weekly');
            if (!$result) {
                $dom = ZLanguage::getModuleDomain('Weekly');
                LogUtil::registerError(__('Error! Could not load the associated workflow.', $dom));
            }
        }
        
        if (!is_object($this['__WORKFLOW__']) && !isset($this['__WORKFLOW__']['schemaname'])) {
            $workflow = $this['__WORKFLOW__'];
            $workflow['schemaname'] = $schemaName;
            $this['__WORKFLOW__'] = $workflow;
        }
    }
    
    /**
     * Resets workflow data back to initial state.
     * To be used after cloning an entity object.
     */
    public function resetWorkflow()
    {
        $this->setWorkflowState('initial');
        $workflowHelper = new Weekly_Util_Workflow(ServiceUtil::getManager());
        $schemaName = $workflowHelper->getWorkflowName($this['_objectType']);
        $this['__WORKFLOW__'] = array(
            'state' => $this['workflowState'],
            'obj_table' => $this['_objectType'],
            'obj_idcolumn' => 'id',
            'obj_id' => 0,
            'schemaname' => $schemaName);
    }
    
    /**
     * Start validation and raise exception if invalid data is found.
     *
     * @return void.
     *
     * @throws Zikula_Exception Thrown if a validation error occurs
     */
    public function validate()
    {
        if ($this->_bypassValidation === true) {
            return;
        }
    
        $result = $this->initValidator()->validateAll();
        if (is_array($result)) {
            throw new Zikula_Exception($result['message'], $result['code'], $result['debugArray']);
        }
    }
    
    /**
     * Return entity data in JSON format.
     *
     * @return string JSON-encoded data.
     */
    public function toJson()
    {
        return json_encode($this->toArray());
    }
    
    /**
     * Collect available actions for this entity.
     */
    protected function prepareItemActions()
    {
        if (!empty($this->_actions)) {
            return;
        }
    
        $currentType = FormUtil::getPassedValue('type', 'user', 'GETPOST', FILTER_SANITIZE_STRING);
        $currentFunc = FormUtil::getPassedValue('func', 'main', 'GETPOST', FILTER_SANITIZE_STRING);
        $dom = ZLanguage::getModuleDomain('Weekly');
        if ($currentType == 'admin') {
            if (in_array($currentFunc, array('main', 'view'))) {
                $this->_actions[] = array(
                    'url' => array('type' => 'user', 'func' => 'display', 'arguments' => array('ot' => 'event', 'id' => $this['id'])),
                    'icon' => 'preview',
                    'linkTitle' => __('Open preview page', $dom),
                    'linkText' => __('Preview', $dom)
                );
                $this->_actions[] = array(
                    'url' => array('type' => 'admin', 'func' => 'display', 'arguments' => array('ot' => 'event', 'id' => $this['id'])),
                    'icon' => 'display',
                    'linkTitle' => str_replace('"', '', $this->getTitleFromDisplayPattern()),
                    'linkText' => __('Details', $dom)
                );
            }
            if (in_array($currentFunc, array('main', 'view', 'display'))) {
                $component = 'Weekly:Event:';
                $instance = $this->id . '::';
                if (SecurityUtil::checkPermission($component, $instance, ACCESS_EDIT)) {
                    $this->_actions[] = array(
                        'url' => array('type' => 'admin', 'func' => 'edit', 'arguments' => array('ot' => 'event', 'id' => $this['id'])),
                        'icon' => 'edit',
                        'linkTitle' => __('Edit', $dom),
                        'linkText' => __('Edit', $dom)
                    );
                    $this->_actions[] = array(
                        'url' => array('type' => 'admin', 'func' => 'edit', 'arguments' => array('ot' => 'event', 'astemplate' => $this['id'])),
                        'icon' => 'saveas',
                        'linkTitle' => __('Reuse for new item', $dom),
                        'linkText' => __('Reuse', $dom)
                    );
                }
            }
            if ($currentFunc == 'display') {
                $this->_actions[] = array(
                    'url' => array('type' => 'admin', 'func' => 'view', 'arguments' => array('ot' => 'event')),
                    'icon' => 'back',
                    'linkTitle' => __('Back to overview', $dom),
                    'linkText' => __('Back to overview', $dom)
                );
            }
        }
        if ($currentType == 'user') {
            if (in_array($currentFunc, array('main', 'view'))) {
                $this->_actions[] = array(
                    'url' => array('type' => 'user', 'func' => 'display', 'arguments' => array('ot' => 'event', 'id' => $this['id'])),
                    'icon' => 'display',
                    'linkTitle' => str_replace('"', '', $this->getTitleFromDisplayPattern()),
                    'linkText' => __('Details', $dom)
                );
            }
            if (in_array($currentFunc, array('main', 'view', 'display'))) {
                $component = 'Weekly:Event:';
                $instance = $this->id . '::';
                if (SecurityUtil::checkPermission($component, $instance, ACCESS_EDIT)) {
                    $this->_actions[] = array(
                        'url' => array('type' => 'user', 'func' => 'edit', 'arguments' => array('ot' => 'event', 'id' => $this['id'])),
                        'icon' => 'edit',
                        'linkTitle' => __('Edit', $dom),
                        'linkText' => __('Edit', $dom)
                    );
                    $this->_actions[] = array(
                        'url' => array('type' => 'user', 'func' => 'edit', 'arguments' => array('ot' => 'event', 'astemplate' => $this['id'])),
                        'icon' => 'saveas',
                        'linkTitle' => __('Reuse for new item', $dom),
                        'linkText' => __('Reuse', $dom)
                    );
                }
            }
            if ($currentFunc == 'display') {
                $this->_actions[] = array(
                    'url' => array('type' => 'user', 'func' => 'view', 'arguments' => array('ot' => 'event')),
                    'icon' => 'back',
                    'linkTitle' => __('Back to overview', $dom),
                    'linkText' => __('Back to overview', $dom)
                );
            }
        }
    }
    
    /**
     * Creates url arguments array for easy creation of display urls.
     *
     * @return Array The resulting arguments list.
     */
    public function createUrlArgs()
    {
        $args = array('ot' => $this['_objectType']);
    
        $args['id'] = $this['id'];
    
        if (isset($this['slug'])) {
            $args['slug'] = $this['slug'];
        }
    
        return $args;
    }
    
    /**
     * Create concatenated identifier string (for composite keys).
     *
     * @return String concatenated identifiers.
     */
    public function createCompositeIdentifier()
    {
        $itemId = $this['id'];
    
        return $itemId;
    }
    
    /**
     * Return lower case name of multiple items needed for hook areas.
     *
     * @return string
     */
    public function getHookAreaPrefix()
    {
        return 'weekly.ui_hooks.events';
    }

    
    /**
     * Post-Process the data after the entity has been constructed by the entity manager.
     * The event happens after the entity has been loaded from database or after a refresh call.
     *
     * Restrictions:
     *     - no access to entity manager or unit of work apis
     *     - no access to associations (not initialised yet)
     *
     * @see Weekly_Entity_Event::postLoadCallback()
     * @return boolean true if completed successfully else false.
     */
    protected function performPostLoadCallback()
    {
        // echo 'loaded a record ...';
        $currentFunc = FormUtil::getPassedValue('func', 'main', 'GETPOST', FILTER_SANITIZE_STRING);
        $usesCsvOutput = FormUtil::getPassedValue('usecsvext', false, 'GETPOST', FILTER_SANITIZE_STRING);
        
        $this['id'] = (int) ((isset($this['id']) && !empty($this['id'])) ? DataUtil::formatForDisplay($this['id']) : 0);
        $this->formatTextualField('workflowState', $currentFunc, $usesCsvOutput, true);
        $this->formatTextualField('eventName', $currentFunc, $usesCsvOutput);
        $this->formatTextualField('eventDay', $currentFunc, $usesCsvOutput, true);
        $this->formatTextualField('eventBeginText', $currentFunc, $usesCsvOutput);
        $this['eventDuration'] = (int) ((isset($this['eventDuration']) && !empty($this['eventDuration'])) ? DataUtil::formatForDisplay($this['eventDuration']) : 0);
        $this->formatTextualField('eventMessage', $currentFunc, $usesCsvOutput);
        $this->formatTextualField('eventText', $currentFunc, $usesCsvOutput);
        $this['maxParticipants'] = (int) ((isset($this['maxParticipants']) && !empty($this['maxParticipants'])) ? DataUtil::formatForDisplay($this['maxParticipants']) : 0);
        $this['currentParticipants'] = (int) ((isset($this['currentParticipants']) && !empty($this['currentParticipants'])) ? DataUtil::formatForDisplay($this['currentParticipants']) : 0);
        $this['active'] = (bool) $this['active'];
    
        $this->prepareItemActions();
    
        return true;
    }
    
    /**
     * Formats a given textual field depending on it's actual kind of content.
     *
     * @param string  $fieldName     Name of field to be formatted.
     * @param string  $currentFunc   Name of current controller action.
     * @param string  $usesCsvOutput Whether the output is CSV or not (defaults to false).
     * @param boolean $allowZero     Whether 0 values are allowed or not (defaults to false).
     */
    protected function formatTextualField($fieldName, $currentFunc, $usesCsvOutput = false, $allowZero = false)
    {
        if ($currentFunc == 'edit') {
            // apply no changes when editing the content
            return;
        }
    
        $string = '';
        if (isset($this[$fieldName])) {
            if (!empty($this[$fieldName]) || ($allowZero && $this[$fieldName] == 0)) {
                $string = $this[$fieldName];
                if ($usesCsvOutput == 1) {
                    // strip only quotes when displaying raw output in CSV
                    $string = str_replace('"', '""', $string);
                } else {
                    if ($this->containsHtml($string)) {
                        $string = DataUtil::formatForDisplayHTML($string);
                    } else {
                        $string = DataUtil::formatForDisplay($string);
                        $string = nl2br($string);
                    }
                }
            }
        }
    
        $this[$fieldName] = $string;
    }
    
    /**
     * Checks whether any html tags are contained in the given string.
     * See http://stackoverflow.com/questions/10778035/how-to-check-if-string-contents-have-any-html-in-it for implementation details.
     *
     * @param $string string The given input string.
     *
     * @return boolean Whether any html tags are found or not.
     */
    protected function containsHtml($string)
    {
        return preg_match("/<[^<]+>/", $string, $m) != 0;
    }
    
    /**
     * Pre-Process the data prior to an insert operation.
     * The event happens before the entity managers persist operation is executed for this entity.
     *
     * Restrictions:
     *     - no access to entity manager or unit of work apis
     *     - no identifiers available if using an identity generator like sequences
     *     - Doctrine won't recognize changes on relations which are done here
     *       if this method is called by cascade persist
     *     - no creation of other entities allowed
     *
     * @see Weekly_Entity_Event::prePersistCallback()
     * @return boolean true if completed successfully else false.
     */
    protected function performPrePersistCallback()
    {
        // echo 'inserting a record ...';
        $this->validate();
    
        return true;
    }
    
    /**
     * Post-Process the data after an insert operation.
     * The event happens after the entity has been made persistant.
     * Will be called after the database insert operations.
     * The generated primary key values are available.
     *
     * Restrictions:
     *     - no access to entity manager or unit of work apis
     *
     * @see Weekly_Entity_Event::postPersistCallback()
     * @return boolean true if completed successfully else false.
     */
    protected function performPostPersistCallback()
    {
        // echo 'inserted a record ...';
        return true;
    }
    
    /**
     * Pre-Process the data prior a delete operation.
     * The event happens before the entity managers remove operation is executed for this entity.
     *
     * Restrictions:
     *     - no access to entity manager or unit of work apis
     *     - will not be called for a DQL DELETE statement
     *
     * @see Weekly_Entity_Event::preRemoveCallback()
     * @return boolean true if completed successfully else false.
     */
    protected function performPreRemoveCallback()
    {
        // delete workflow for this entity
        $workflow = $this['__WORKFLOW__'];
        if ($workflow['id'] > 0) {
            $result = (bool) DBUtil::deleteObjectByID('workflows', $workflow['id']);
            if ($result === false) {
                $dom = ZLanguage::getModuleDomain('Weekly');
                return LogUtil::registerError(__('Error! Could not remove stored workflow. Deletion has been aborted.', $dom));
            }
        }
    
        return true;
    }
    
    /**
     * Post-Process the data after a delete.
     * The event happens after the entity has been deleted.
     * Will be called after the database delete operations.
     *
     * Restrictions:
     *     - no access to entity manager or unit of work apis
     *     - will not be called for a DQL DELETE statement
     *
     * @see Weekly_Entity_Event::postRemoveCallback()
     * @return boolean true if completed successfully else false.
     */
    protected function performPostRemoveCallback()
    {
        // echo 'deleted a record ...';
    
        return true;
    }
    
    /**
     * Pre-Process the data prior to an update operation.
     * The event happens before the database update operations for the entity data.
     *
     * Restrictions:
     *     - no access to entity manager or unit of work apis
     *     - will not be called for a DQL UPDATE statement
     *     - changes on associations are not allowed and won't be recognized by flush
     *     - changes on properties won't be recognized by flush as well
     *     - no creation of other entities allowed
     *
     * @see Weekly_Entity_Event::preUpdateCallback()
     * @return boolean true if completed successfully else false.
     */
    protected function performPreUpdateCallback()
    {
        // echo 'updating a record ...';
        $this->validate();
    
        return true;
    }
    
    /**
     * Post-Process the data after an update operation.
     * The event happens after the database update operations for the entity data.
     *
     * Restrictions:
     *     - no access to entity manager or unit of work apis
     *     - will not be called for a DQL UPDATE statement
     *
     * @see Weekly_Entity_Event::postUpdateCallback()
     * @return boolean true if completed successfully else false.
     */
    protected function performPostUpdateCallback()
    {
        // echo 'updated a record ...';
        return true;
    }
    
    /**
     * Pre-Process the data prior to a save operation.
     * This combines the PrePersist and PreUpdate events.
     * For more information see corresponding callback handlers.
     *
     * @see Weekly_Entity_Event::preSaveCallback()
     * @return boolean true if completed successfully else false.
     */
    protected function performPreSaveCallback()
    {
        // echo 'saving a record ...';
        $this->validate();
    
        return true;
    }
    
    /**
     * Post-Process the data after a save operation.
     * This combines the PostPersist and PostUpdate events.
     * For more information see corresponding callback handlers.
     *
     * @see Weekly_Entity_Event::postSaveCallback()
     * @return boolean true if completed successfully else false.
     */
    protected function performPostSaveCallback()
    {
        // echo 'saved a record ...';
        return true;
    }
    

    /**
     * Returns the formatted title conforming to the display pattern
     * specified for this entity.
     */
    public function getTitleFromDisplayPattern()
    {
        $serviceManager = ServiceUtil::getManager();
        $listHelper = new Weekly_Util_ListEntries($serviceManager);
    
        $formattedTitle = ''
                . $listHelper->resolve($this->getEventDay(), 'event', 'eventDay')
                . ' '
                . $this->getEventBeginText()
                . ': '
                . $this->getEventName();
    
        return $formattedTitle;
    }

    /**
     * ToString interceptor implementation.
     * This method is useful for debugging purposes.
     */
    public function __toString()
    {
        return $this->getId();
    }

    /**
     * Clone interceptor implementation.
     * This method is for example called by the reuse functionality.
     * Performs a deep copy.
     *
     * See also:
     * (1) http://docs.doctrine-project.org/en/latest/cookbook/implementing-wakeup-or-clone.html
     * (2) http://www.sunilb.com/php/php5-oops-tutorial-magic-methods-__clone-method
     * (3) http://stackoverflow.com/questions/185934/how-do-i-create-a-copy-of-an-object-in-php
     * (4) http://www.pantovic.com/article/26/doctrine2-entity-cloning
     */
    public function __clone()
    {
        // If the entity has an identity, proceed as normal.
        if ($this->id) {
            // create new instance
            
            $entity = new \Weekly_Entity_Event();
            // unset identifiers
            $entity->setId(null);
            // copy simple fields
            $entity->set_objectType($this->get_objectType());
            $entity->set_actions($this->get_actions());
            $entity->initValidator();
            $entity->setEventBegin($this->getEventBegin());
            $entity->setEventName($this->getEventName());
            $entity->setEventDay($this->getEventDay());
            $entity->setEventBeginText($this->getEventBeginText());
            $entity->setEventDuration($this->getEventDuration());
            $entity->setEventMessage($this->getEventMessage());
            $entity->setEventText($this->getEventText());
            $entity->setMaxParticipants($this->getMaxParticipants());
            $entity->setCurrentParticipants($this->getCurrentParticipants());
            $entity->setActive($this->getActive());
    
            // handle related objects
            // prevent shared references by doing a deep copy - see (2) and (3) for more information
            if ($this->getKind() != null) {
                $this->kind = clone $this->kind;
                $entity->setKind($this->kind);
            }
            if ($this->getLocation() != null) {
                $this->location = clone $this->location;
                $entity->setLocation($this->location);
            }
            if ($this->getManager() != null) {
                $this->manager = clone $this->manager;
                $entity->setManager($this->manager);
            }
            if ($this->getComanager() != null) {
                $this->comanager = clone $this->comanager;
                $entity->setComanager($this->comanager);
            }
    
            return $entity;
        }
        // otherwise do nothing, do NOT throw an exception!
    }
}
