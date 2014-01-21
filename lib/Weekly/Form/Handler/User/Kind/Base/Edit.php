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
 * This handler class handles the page events of the Form called by the weekly_user_edit() function.
 * It aims on the kind object type.
 *
 * More documentation is provided in the parent class.
 */
class Weekly_Form_Handler_User_Kind_Base_Edit extends Weekly_Form_Handler_User_Edit
{
    /**
     * Pre-initialise hook.
     *
     * @return void
     */
    public function preInitialize()
    {
        parent::preInitialize();

        $this->objectType = 'kind';
        $this->objectTypeCapital = 'Kind';
        $this->objectTypeLower = 'kind';

        $this->hasPageLockSupport = true;
        // array with upload fields and mandatory flags
        $this->uploadFields = array('kindPicture' => false);
        // array with list fields and multiple flags
        $this->listFields = array('workflowState' => false);
    }

    /**
     * Initialize form handler.
     *
     * This method takes care of all necessary initialisation of our data and form states.
     *
     * @param Zikula_Form_View $view The form view instance.
     *
     * @return boolean False in case of initialization errors, otherwise true.
     */
    public function initialize(Zikula_Form_View $view)
    {
        parent::initialize($view);
    
        if ($this->mode == 'create') {
            $modelHelper = new Weekly_Util_Model($this->view->getServiceManager());
            if (!$modelHelper->canBeCreated($this->objectType)) {
                LogUtil::registerError($this->__('Sorry, but you can not create the kind yet as other items are required which must be created before!'));
    
                return $this->view->redirect($this->getRedirectUrl(null));
            }
        }
    
        $entity = $this->entityRef;
    
        // save entity reference for later reuse
        $this->entityRef = $entity;
    
        $entityData = $entity->toArray();
    
        if (count($this->listFields) > 0) {
            $helper = new Weekly_Util_ListEntries($this->view->getServiceManager());
            foreach ($this->listFields as $listField => $isMultiple) {
                $entityData[$listField . 'Items'] = $helper->getEntries($this->objectType, $listField);
                if ($isMultiple) {
                    $entityData[$listField] = $helper->extractMultiList($entityData[$listField]);
                }
            }
        }
    
        // assign data to template as array (makes translatable support easier)
        $this->view->assign($this->objectTypeLower, $entityData);
    
        if ($this->mode == 'edit') {
            // assign formatted title
            $this->view->assign('formattedEntityTitle', $entity->getTitleFromDisplayPattern());
        }
    
        // everything okay, no initialization errors occured
        return true;
    }

    /**
     * Post-initialise hook.
     *
     * @return void
     */
    public function postInitialize()
    {
        parent::postInitialize();
    }

    /**
     * Get list of allowed redirect codes.
     *
     * @return array list of possible redirect codes
     */
    protected function getRedirectCodes()
    {
        $codes = parent::getRedirectCodes();
    
        return $codes;
    }

    /**
     * Get the default redirect url. Required if no returnTo parameter has been supplied.
     * This method is called in handleCommand so we know which command has been performed.
     *
     * @param array  $args List of arguments.
     *
     * @return string The default redirect url.
     */
    protected function getDefaultReturnUrl($args)
    {
        // redirect to the list of kind
        $viewArgs = array('ot' => $this->objectType);
        $url = ModUtil::url($this->name, 'user', 'view', $viewArgs);
    
        return $url;
    }

    /**
     * Command event handler.
     *
     * This event handler is called when a command is issued by the user.
     *
     * @param Zikula_Form_View $view The form view instance.
     * @param array            $args Additional arguments.
     *
     * @return mixed Redirect or false on errors.
     */
    public function handleCommand(Zikula_Form_View $view, &$args)
    {
        $result = parent::handleCommand($view, $args);
        if ($result === false) {
            return $result;
        }
    
        return $this->view->redirect($this->getRedirectUrl($args));
    }
    
    /**
     * Get success or error message for default operations.
     *
     * @param Array   $args    Arguments from handleCommand method.
     * @param Boolean $success Becomes true if this is a success, false for default error.
     *
     * @return String desired status or error message.
     */
    protected function getDefaultMessage($args, $success = false)
    {
        if ($success !== true) {
            return parent::getDefaultMessage($args, $success);
        }
    
        $message = '';
        switch ($args['commandName']) {
            case 'submit':
                        if ($this->mode == 'create') {
                            $message = $this->__('Done! Kind created.');
                        } else {
                            $message = $this->__('Done! Kind updated.');
                        }
                        break;
            case 'delete':
                        $message = $this->__('Done! Kind deleted.');
                        break;
            default:
                        $message = $this->__('Done! Kind updated.');
                        break;
        }
    
        return $message;
    }

    /**
     * This method executes a certain workflow action.
     *
     * @param Array $args Arguments from handleCommand method.
     *
     * @return bool Whether everything worked well or not.
     */
    public function applyAction(array $args = array())
    {
        // get treated entity reference from persisted member var
        $entity = $this->entityRef;
    
        $action = $args['commandName'];
    
        try {
            // execute the workflow action
            $workflowHelper = new Weekly_Util_Workflow($this->view->getServiceManager());
            $success = $workflowHelper->executeAction($entity, $action);
        } catch(\Exception $e) {
            LogUtil::registerError($this->__f('Sorry, but an unknown error occured during the %s action. Please apply the changes again!', array($action)));
        }
    
        $this->addDefaultMessage($args, $success);
    
        if ($success && $this->mode == 'create') {
            // store new identifier
            foreach ($this->idFields as $idField) {
                $this->idValues[$idField] = $entity[$idField];
            }
        }
    
    
        return $success;
    }

    /**
     * Get url to redirect to.
     *
     * @param array  $args List of arguments.
     *
     * @return string The redirect url.
     */
    protected function getRedirectUrl($args)
    {
        if ($this->inlineUsage == true) {
            $urlArgs = array('idPrefix'    => $this->idPrefix,
                             'commandName' => $args['commandName']);
            $urlArgs = $this->addIdentifiersToUrlArgs($urlArgs);
    
            // inline usage, return to special function for closing the Zikula.UI.Window instance
            return ModUtil::url($this->name, 'user', 'handleInlineRedirect', $urlArgs);
        }
    
        if ($this->repeatCreateAction) {
            return $this->repeatReturnUrl;
        }
    
        // normal usage, compute return url from given redirect code
        if (!in_array($this->returnTo, $this->getRedirectCodes())) {
            // invalid return code, so return the default url
            return $this->getDefaultReturnUrl($args);
        }
    
        // parse given redirect code and return corresponding url
        switch ($this->returnTo) {
            case 'ajax':
                        return ModUtil::url($this->name, 'ajax', 'main');
                    default:
                        return $this->getDefaultReturnUrl($args);
        }
    }
}
