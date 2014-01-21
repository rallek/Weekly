{* purpose of this template: inclusion template for managing related organisator in admin area *}
{if !isset($displayMode)}
    {assign var='displayMode' value='dropdown'}
{/if}
{if !isset($allowEditing)}
    {assign var='allowEditing' value=false}
{/if}
{if isset($panel) && $panel eq true}
    <h3 class="organisator z-panel-header z-panel-indicator z-pointer">{gt text='Organisator'}</h3>
    <fieldset class="organisator z-panel-content" style="display: none">
{else}
    <fieldset class="organisator">
{/if}
    <legend>{gt text='Organisator'}</legend>
    <div class="z-formrow">
    {if $displayMode eq 'dropdown'}
        {formlabel for=$alias __text='Choose organisator'}
            {weeklyRelationSelectorList group=$group id=$alias aliasReverse=$aliasReverse mandatory=$mandatory __title='Choose the organisator' selectionMode='single' objectType='organisator' linkingItem=$linkingItem}
    {elseif $displayMode eq 'autocomplete'}
        {assign var='createLink' value=''}
        {if $allowEditing eq true}
            {modurl modname='Weekly' type='admin' func='edit' ot='organisator' assign='createLink'}
        {/if}
        {weeklyRelationSelectorAutoComplete group=$group id=$alias aliasReverse=$aliasReverse mandatory=$mandatory __title='Choose the organisator' selectionMode='single' objectType='organisator' linkingItem=$linkingItem idPrefix=$idPrefix createLink=$createLink withImage=true}
        <div class="weekly-relation-leftside">
            {if isset($linkingItem.$alias)}
                {include file='admin/organisator/include_selectItemListOne.tpl'  item=$linkingItem.$alias}
            {else}
                {include file='admin/organisator/include_selectItemListOne.tpl' }
            {/if}
        </div>
        <br class="z-clearer" />
    {/if}
    </div>
</fieldset>
