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
 * Repository class used to implement own convenience methods for performing certain DQL queries.
 *
 * This is the concrete repository class for event entities.
 */
class Weekly_Entity_Repository_Event extends Weekly_Entity_Repository_Base_Event
{
    // feel free to add your own methods here, like for example reusable DQL queries
	
	    /**
     * @var string The default sorting field/expression.
     */
    protected $defaultSortingField = 'eventBegin';
}
