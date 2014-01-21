{* Purpose of this template: edit view of generic item list content type *}

<div class="z-formrow">
    {gt text='Object type' domain='module_weekly' assign='objectTypeSelectorLabel'}
    {formlabel for='weeklyObjectType' text=$objectTypeSelectorLabel}
        {weeklyObjectTypeSelector assign='allObjectTypes'}
        {formdropdownlist id='weeklyOjectType' dataField='objectType' group='data' mandatory=true items=$allObjectTypes}
        <span class="z-sub z-formnote">{gt text='If you change this please save the element once to reload the parameters below.' domain='module_weekly'}</span>
</div>

{formvolatile}
{if $properties ne null && is_array($properties)}
    {nocache}
    {foreach key='registryId' item='registryCid' from=$registries}
        {assign var='propName' value=''}
        {foreach key='propertyName' item='propertyId' from=$properties}
            {if $propertyId eq $registryId}
                {assign var='propName' value=$propertyName}
            {/if}
        {/foreach}
        <div class="z-formrow">
            {modapifunc modname='Weekly' type='category' func='hasMultipleSelection' ot=$objectType registry=$propertyName assign='hasMultiSelection'}
            {gt text='Category' domain='module_weekly' assign='categorySelectorLabel'}
            {assign var='selectionMode' value='single'}
            {if $hasMultiSelection eq true}
                {gt text='Categories' domain='module_weekly' assign='categorySelectorLabel'}
                {assign var='selectionMode' value='multiple'}
            {/if}
            {formlabel for="weeklyCatIds`$propertyName`" text=$categorySelectorLabel}
                {formdropdownlist id="weeklyCatIds`$propName`" items=$categories.$propName dataField="catids`$propName`" group='data' selectionMode=$selectionMode}
                <span class="z-sub z-formnote">{gt text='This is an optional filter.' domain='module_weekly'}</span>
        </div>
    {/foreach}
    {/nocache}
{/if}
{/formvolatile}

<div class="z-formrow">
    {gt text='Sorting' domain='module_weekly' assign='sortingLabel'}
    {formlabel text=$sortingLabel}
    <div>
        {formradiobutton id='weeklySortRandom' value='random' dataField='sorting' group='data' mandatory=true}
        {gt text='Random' domain='module_weekly' assign='sortingRandomLabel'}
        {formlabel for='weeklySortRandom' text=$sortingRandomLabel}
        {formradiobutton id='weeklySortNewest' value='newest' dataField='sorting' group='data' mandatory=true}
        {gt text='Newest' domain='module_weekly' assign='sortingNewestLabel'}
        {formlabel for='weeklySortNewest' text=$sortingNewestLabel}
        {formradiobutton id='weeklySortDefault' value='default' dataField='sorting' group='data' mandatory=true}
        {gt text='Default' domain='module_weekly' assign='sortingDefaultLabel'}
        {formlabel for='weeklySortDefault' text=$sortingDefaultLabel}
    </div>
</div>

<div class="z-formrow">
    {gt text='Amount' domain='module_weekly' assign='amountLabel'}
    {formlabel for='weeklyAmount' text=$amountLabel}
        {formintinput id='weeklyAmount' dataField='amount' group='data' mandatory=true maxLength=2}
</div>

<div class="z-formrow">
    {gt text='Template' domain='module_weekly' assign='templateLabel'}
    {formlabel for='weeklyTemplate' text=$templateLabel}
        {weeklyTemplateSelector assign='allTemplates'}
        {formdropdownlist id='weeklyTemplate' dataField='template' group='data' mandatory=true items=$allTemplates}
</div>

<div id="customTemplateArea" class="z-formrow z-hide">
    {gt text='Custom template' domain='module_weekly' assign='customTemplateLabel'}
    {formlabel for='weeklyCustomTemplate' text=$customTemplateLabel}
        {formtextinput id='weeklyCustomTemplate' dataField='customTemplate' group='data' mandatory=false maxLength=80}
        <span class="z-sub z-formnote">{gt text='Example' domain='module_weekly'}: <em>itemlist_[objecttype]_display.tpl</em></span>
</div>

<div class="z-formrow z-hide">
    {gt text='Filter (expert option)' domain='module_weekly' assign='filterLabel'}
    {formlabel for='weeklyFilter' text=$filterLabel}
        {formtextinput id='weeklyFilter' dataField='filter' group='data' mandatory=false maxLength=255}
        <span class="z-sub z-formnote">
            ({gt text='Syntax examples'}: <kbd>name:like:foobar</kbd> {gt text='or'} <kbd>status:ne:3</kbd>)
        </span>
</div>

{pageaddvar name='javascript' value='prototype'}
<script type="text/javascript">
/* <![CDATA[ */
    function weeklyToggleCustomTemplate() {
        if ($F('weeklyTemplate') == 'custom') {
            $('customTemplateArea').removeClassName('z-hide');
        } else {
            $('customTemplateArea').addClassName('z-hide');
        }
    }

    document.observe('dom:loaded', function() {
        weeklyToggleCustomTemplate();
        $('weeklyTemplate').observe('change', function(e) {
            weeklyToggleCustomTemplate();
        });
    });
/* ]]> */
</script>
