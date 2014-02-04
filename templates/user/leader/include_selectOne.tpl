{* purpose of this template: inclusion template for managing related manager in user area *}
{if !isset($displayMode)}
    {assign var='displayMode' value='dropdown'}
{/if}
{if !isset($allowEditing)}
    {assign var='allowEditing' value=false}
{/if}
{if isset($panel) && $panel eq true}
    <h3 class="manager z-panel-header z-panel-indicator z-pointer">{gt text='Manager'}</h3>
    <fieldset class="manager z-panel-content" style="display: none">
{else}
    <fieldset class="manager">
{/if}
    <legend>{gt text='Manager'}</legend>
    <div class="z-formrow">
    {if $displayMode eq 'dropdown'}
        {formlabel for=$alias __text='Choose manager'}
            {weeklyRelationSelectorList group=$group id=$alias aliasReverse=$aliasReverse mandatory=$mandatory __title='Choose the manager' selectionMode='single' objectType='manager' linkingItem=$linkingItem}
    {elseif $displayMode eq 'autocomplete'}
        {assign var='createLink' value=''}
        {if $allowEditing eq true}
            {modurl modname='Weekly' type='user' func='edit' ot='manager' forcelongurl=true assign='createLink'}
        {/if}
        {weeklyRelationSelectorAutoComplete group=$group id=$alias aliasReverse=$aliasReverse mandatory=$mandatory __title='Choose the manager' selectionMode='single' objectType='manager' linkingItem=$linkingItem idPrefix=$idPrefix createLink=$createLink withImage=true}
        <div class="weekly-relation-leftside">
            {if isset($linkingItem.$alias)}
                {include file='user/manager/include_selectItemListOne.tpl'  item=$linkingItem.$alias}
            {else}
                {include file='user/manager/include_selectItemListOne.tpl' }
            {/if}
        </div>
        <br class="z-clearer" />
    {/if}
    </div>
</fieldset>
