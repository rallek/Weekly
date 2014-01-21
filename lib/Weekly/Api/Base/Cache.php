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
 * Cache api base class.
 */
class Weekly_Api_Base_Cache extends Zikula_AbstractApi
{
    /**
     * Clear cache for given item. Can be called from other modules to clear an item cache.
     *
     * @param $args['ot']   the treated object type
     * @param $args['item'] the actual object
     */
    public function clearItemCache(array $args = array())
    {
        if (!isset($args['ot']) || !isset($args['item'])) {
            return;
        }
    
        $objectType = $args['ot'];
        $item = $args['item'];
    
        $controllerHelper = new Weekly_Util_Controller($this->serviceManager);
        $utilArgs = array('api' => 'cache', 'action' => 'clearItemCache');
        if (!in_array($objectType, $controllerHelper->getObjectTypes('controllerAction', $utilArgs))) {
            return;
        }
    
        if ($item && !is_array($item) && !is_object($item)) {
            $item = ModUtil::apiFunc($this->name, 'selection', 'getEntity', array('ot' => $objectType, 'id' => $item, 'useJoins' => false, 'slimMode' => true));
        }
    
        if (!$item) {
            return;
        }
    
        // create full identifier (considering composite keys)
        $idFields = ModUtil::apiFunc($this->name, 'selection', 'getIdFields', array('ot' => $objectType));
        $instanceId = '';
        foreach ($idFields as $idField) {
            if (!empty($instanceId)) {
                $instanceId .= '_';
            }
            $instanceId .= $item[$idField];
        }
    
    
        // Clear View_cache
        $cacheIds = array();
        $cacheIds[] = 'main';
        $cacheIds[] = 'view';
        $cacheIds[] = $instanceId;
        
        
    
        $view = Zikula_View::getInstance('Weekly');
        foreach ($cacheIds as $cacheId) {
            $view->clear_cache(null, $cacheId);
        }
    
    
        // Clear Theme_cache
        $cacheIds = array();
        $cacheIds[] = 'homepage'; // for homepage (can be assigned in the Settings module)
        $cacheIds[] = 'Weekly/user/main'; // main function
        $cacheIds[] = 'Weekly/user/view/' . $objectType; // view function (list views)
        $cacheIds[] = 'Weekly/user/display/' . $objectType . '|' . $instanceId; // display function (detail views)
        
        
        $theme = Zikula_View_Theme::getInstance();
        $theme->clear_cacheid_allthemes($cacheIds);
    }
}
