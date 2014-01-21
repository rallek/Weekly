{* purpose of this template: inclusion template for managing related location in admin area *}
{if !isset($displayMode)}
    {assign var='displayMode' value='dropdown'}
{/if}
{if !isset($allowEditing)}
    {assign var='allowEditing' value=false}
{/if}
{if isset($panel) && $panel eq true}
    <h3 class="location z-panel-header z-panel-indicator z-pointer">{gt text='Location'}</h3>
    <fieldset class="location z-panel-content" style="display: none">
{else}
    <fieldset class="location">
{/if}
    <legend>{gt text='Location'}</legend>
    <div class="z-formrow">
    {if $displayMode eq 'dropdown'}
        {formlabel for=$alias __text='Choose location'}
            {weeklyRelationSelectorList group=$group id=$alias aliasReverse=$aliasReverse mandatory=$mandatory __title='Choose the location' selectionMode='single' objectType='location' linkingItem=$linkingItem}
    {elseif $displayMode eq 'autocomplete'}
        {assign var='createLink' value=''}
        {if $allowEditing eq true}
            {modurl modname='Weekly' type='admin' func='edit' ot='location' assign='createLink'}
        {/if}
        {weeklyRelationSelectorAutoComplete group=$group id=$alias aliasReverse=$aliasReverse mandatory=$mandatory __title='Choose the location' selectionMode='single' objectType='location' linkingItem=$linkingItem idPrefix=$idPrefix createLink=$createLink withImage=true}
        <div class="weekly-relation-leftside">
            {if isset($linkingItem.$alias)}
                {include file='admin/location/include_selectItemListOne.tpl'  item=$linkingItem.$alias}
            {else}
                {include file='admin/location/include_selectItemListOne.tpl' }
            {/if}
        </div>
        <br class="z-clearer" />
    {/if}
    </div>
</fieldset>
