{* purpose of this template: inclusion template for managing related leader in user area *}
{if !isset($displayMode)}
    {assign var='displayMode' value='dropdown'}
{/if}
{if !isset($allowEditing)}
    {assign var='allowEditing' value=false}
{/if}
{if isset($panel) && $panel eq true}
    <h3 class="leader z-panel-header z-panel-indicator z-pointer">{gt text='Leader'}</h3>
    <fieldset class="leader z-panel-content" style="display: none">
{else}
    <fieldset class="leader">
{/if}
    <legend>{gt text='Leader'}</legend>
    <div class="z-formrow">
    {if $displayMode eq 'dropdown'}
        {formlabel for=$alias __text='Choose leader'}
            {weeklyRelationSelectorList group=$group id=$alias aliasReverse=$aliasReverse mandatory=$mandatory __title='Choose the leader' selectionMode='single' objectType='leader' linkingItem=$linkingItem}
    {elseif $displayMode eq 'autocomplete'}
        {assign var='createLink' value=''}
        {if $allowEditing eq true}
            {modurl modname='Weekly' type='user' func='edit' ot='leader' forcelongurl=true assign='createLink'}
        {/if}
        {weeklyRelationSelectorAutoComplete group=$group id=$alias aliasReverse=$aliasReverse mandatory=$mandatory __title='Choose the leader' selectionMode='single' objectType='leader' linkingItem=$linkingItem idPrefix=$idPrefix createLink=$createLink withImage=true}
        <div class="weekly-relation-leftside">
            {if isset($linkingItem.$alias)}
                {include file='user/leader/include_selectItemListOne.tpl'  item=$linkingItem.$alias}
            {else}
                {include file='user/leader/include_selectItemListOne.tpl' }
            {/if}
        </div>
        <br class="z-clearer" />
    {/if}
    </div>
</fieldset>
