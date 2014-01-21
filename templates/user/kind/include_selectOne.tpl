{* purpose of this template: inclusion template for managing related kind in user area *}
{if !isset($displayMode)}
    {assign var='displayMode' value='dropdown'}
{/if}
{if !isset($allowEditing)}
    {assign var='allowEditing' value=false}
{/if}
{if isset($panel) && $panel eq true}
    <h3 class="kind z-panel-header z-panel-indicator z-pointer">{gt text='Kind'}</h3>
    <fieldset class="kind z-panel-content" style="display: none">
{else}
    <fieldset class="kind">
{/if}
    <legend>{gt text='Kind'}</legend>
    <div class="z-formrow">
    {if $displayMode eq 'dropdown'}
        {formlabel for=$alias __text='Choose kind'}
            {weeklyRelationSelectorList group=$group id=$alias aliasReverse=$aliasReverse mandatory=$mandatory __title='Choose the kind' selectionMode='single' objectType='kind' linkingItem=$linkingItem}
    {elseif $displayMode eq 'autocomplete'}
        {assign var='createLink' value=''}
        {if $allowEditing eq true}
            {modurl modname='Weekly' type='user' func='edit' ot='kind' forcelongurl=true assign='createLink'}
        {/if}
        {weeklyRelationSelectorAutoComplete group=$group id=$alias aliasReverse=$aliasReverse mandatory=$mandatory __title='Choose the kind' selectionMode='single' objectType='kind' linkingItem=$linkingItem idPrefix=$idPrefix createLink=$createLink withImage=true}
        <div class="weekly-relation-leftside">
            {if isset($linkingItem.$alias)}
                {include file='user/kind/include_selectItemListOne.tpl'  item=$linkingItem.$alias}
            {else}
                {include file='user/kind/include_selectItemListOne.tpl' }
            {/if}
        </div>
        <br class="z-clearer" />
    {/if}
    </div>
</fieldset>
