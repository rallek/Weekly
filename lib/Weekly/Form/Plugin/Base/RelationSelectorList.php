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
 * Relation selector plugin base class.
 */
class Weekly_Form_Plugin_Base_RelationSelectorList extends Weekly_Form_Plugin_AbstractObjectSelector
{
    /**
     * Get filename of this file.
     * The information is used to re-establish the plugins on postback.
     *
     * @return string
     */
    public function getFilename()
    {
        return __FILE__;
    }

    /**
     * Load event handler.
     *
     * @param Zikula_Form_View $view    Reference to Zikula_Form_View object.
     * @param array            &$params Parameters passed from the Smarty plugin function.
     *
     * @return void
     */
    public function load(Zikula_Form_View $view, &$params)
    {
        $this->processRequestData($view, 'GET');

        // load list items
        parent::load($view, $params);

        // preprocess selection: collect id list for related items
        $this->preprocessIdentifiers($view, $params);
    }

    /**
     * Entry point for customised css class.
     */
    protected function getStyleClass()
    {
        return 'z-form-relationlist';
    }

    /**
     * Decode event handler.
     *
     * @param Zikula_Form_View $view Reference to Zikula_Form_View object.
     *
     * @return void
     */
    public function decode(Zikula_Form_View $view)
    {
        parent::decode($view);

        // postprocess selection: reinstantiate objects for identifiers
        $this->processRequestData($view, 'POST');
    }
}
