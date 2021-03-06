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
 * The weeklyObjectTypeSelector plugin provides items for a dropdown selector.
 *
 * Available parameters:
 *   - assign: If set, the results are assigned to the corresponding variable instead of printed out.
 *
 * @param  array            $params All attributes passed to this function from the template.
 * @param  Zikula_Form_View $view   Reference to the view object.
 *
 * @return string The output of the plugin.
 */
function smarty_function_weeklyObjectTypeSelector($params, $view)
{
    $dom = ZLanguage::getModuleDomain('Weekly');
    $result = array();

    $result[] = array('text' => __('Events', $dom), 'value' => 'event');
    $result[] = array('text' => __('Managers', $dom), 'value' => 'manager');
    $result[] = array('text' => __('Comanagers', $dom), 'value' => 'comanager');
    $result[] = array('text' => __('Kind', $dom), 'value' => 'kind');
    $result[] = array('text' => __('Locations', $dom), 'value' => 'location');

    if (array_key_exists('assign', $params)) {
        $view->assign($params['assign'], $result);

        return;
    }

    return $result;
}
