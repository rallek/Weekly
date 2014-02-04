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
 * This is the User api helper class.
 */
class Weekly_Api_User extends Weekly_Api_Base_User
{
    // feel free to add own api methods here
    /**
     * Returns available user panel links.
     *
     * @return array Array of user links.
     */
    public function getlinks()
    {
        $links = array();
		
        if (SecurityUtil::checkPermission($this->name . '::', '::', ACCESS_ADMIN)) {
            $links[] = array('url' => ModUtil::url($this->name, 'admin', 'main'),
                             'text' => $this->__('Backend'),
                             'title' => $this->__('Switch to administration area.'),
                             'class' => 'z-icon-es-options');
        }

        $controllerHelper = new Weekly_Util_Controller($this->serviceManager);
        $utilArgs = array('api' => 'user', 'action' => 'getlinks');
        $allowedObjectTypes = $controllerHelper->getObjectTypes('api', $utilArgs);

        if (in_array('event', $allowedObjectTypes)
            && SecurityUtil::checkPermission($this->name . ':Event:', '::', ACCESS_READ)) {
            $links[] = array('url' => ModUtil::url($this->name, 'user', 'view', array('ot' => 'event')),
                             'text' => $this->__('Events'),
                             'title' => $this->__('Event list'));
        }
		if ($this->getVar('showManager')) {
			if (in_array('manager', $allowedObjectTypes)
				&& SecurityUtil::checkPermission($this->name . ':Manager:', '::', ACCESS_READ)) {
				$links[] = array('url' => ModUtil::url($this->name, 'user', 'view', array('ot' => 'manager')),
								 'text' => $this->__('Managers'),
								 'title' => $this->__('Manager list'));
			}
		}
		if ($this->getVar('showComanager')) {
			if (in_array('comanager', $allowedObjectTypes)
				&& SecurityUtil::checkPermission($this->name . ':Comanager:', '::', ACCESS_READ)) {
				$links[] = array('url' => ModUtil::url($this->name, 'user', 'view', array('ot' => 'comanager')),
								 'text' => $this->__('Comanagers'),
								 'title' => $this->__('Comanager list'));
			}
		}
		if ($this->getVar('showKind')) {
			if (in_array('kind', $allowedObjectTypes)
				&& SecurityUtil::checkPermission($this->name . ':Kind:', '::', ACCESS_READ)) {
				$links[] = array('url' => ModUtil::url($this->name, 'user', 'view', array('ot' => 'kind')),
								 'text' => $this->__('Kind'),
								 'title' => $this->__('Kind list'));
			}
		}
		if ($this->getVar('showLocation')) {
			if (in_array('location', $allowedObjectTypes)
				&& SecurityUtil::checkPermission($this->name . ':Location:', '::', ACCESS_READ)) {
				$links[] = array('url' => ModUtil::url($this->name, 'user', 'view', array('ot' => 'location')),
								 'text' => $this->__('Locations'),
								 'title' => $this->__('Location list'));
			}
		}

        return $links;
    }
}
