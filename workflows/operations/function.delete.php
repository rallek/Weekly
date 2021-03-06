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
 * Delete operation.
 * @param object $entity The treated object.
 * @param array  $params Additional arguments.
 *
 * @return bool False on failure or true if everything worked well.
 */
function Weekly_operation_delete(&$entity, $params)
{
    $dom = ZLanguage::getModuleDomain('Weekly');


    // initialise the result flag
    $result = false;

    // get entity manager
    $serviceManager = ServiceUtil::getManager();
    $entityManager = $serviceManager->getService('doctrine.entitymanager');
    
    // delete entity
    try {
        $entityManager->remove($entity);
        $entityManager->flush();
        $result = true;
    } catch (\Exception $e) {
        LogUtil::registerError($e->getMessage());
    }

    // return result of this operation
    return $result;
}
