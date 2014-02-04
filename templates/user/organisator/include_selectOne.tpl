{* purpose of this template: inclusion template for managing related comanager in user area *}
{if !isset($displayMode)}
    {assign var='displayMode' value='dropdown'}
{/if}
{if !isset($allowEditing)}
    {assign var='allowEditing' value=false}
{/if}
{if isset($panel) && $panel eq true}
    <h3 class="comanager z-panel-header z-panel-indicator z-pointer">{gt text='Comanager'}</h3>
    <fieldset class="comanager z-panel-content" style="display: none">
{else}
    <fieldset class="comanager">
{/if}
    <legend>{gt text='Comanager'}</legend>
    <div class="z-formrow">
    {if $displayMode eq 'dropdown'}
        {formlabel for=$alias __text='Choose comanager'}
            {weeklyRelationSelectorList group=$group id=$alias aliasReverse=$aliasReverse mandatory=$mandatory __title='Choose the comanager' selectionMode='single' objectType='comanager' linkingItem=$linkingItem}
    {elseif $displayMode eq 'autocomplete'}
        {assign var='createLink' value=''}
        {if $allowEditing eq true}
            {modurl modname='Weekly' type='user' func='edit' ot='comanager' forcelongurl=true assign='createLink'}
        {/if}
        {weeklyRelationSelectorAutoComplete group=$group id=$alias aliasReverse=$aliasReverse mandatory=$mandatory __title='Choose the comanager' selectionMode='single' objectType='comanager' linkingItem=$linkingItem idPrefix=$idPrefix createLink=$createLink withImage=true}
        <div class="weekly-relation-leftside">
            {if isset($linkingItem.$alias)}
                {include file='user/comanager/include_selectItemListOne.tpl'  item=$linkingItem.$alias}
            {else}
                {include file='user/comanager/include_selectItemListOne.tpl' }
            {/if}
        </div>
        <br class="z-clearer" />
    {/if}
    </div>
</fieldset>
