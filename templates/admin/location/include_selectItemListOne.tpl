{* purpose of this template: inclusion template for display of related location in admin area *}
{icon type='delete' size='extrasmall' assign='removeImageArray'}
{assign var='removeImage' value="<img src=\"`$removeImageArray.src`\" width=\"16\" height=\"16\" alt=\"\" />"}

{if isset($item) && is_array($item) && isset($item[0]) && !is_object($item[0])}
    {modapifunc modname='Weekly' type='selection' func='getEntity' objectType='location' id=$item[0] assign='item'}
{/if}

<input type="hidden" id="{$idPrefix}ItemList" name="{$idPrefix}ItemList" value="{if isset($item) && (is_array($item) || is_object($item)) && isset($item.id)}{$item.id}{/if}" />
<input type="hidden" id="{$idPrefix}Mode" name="{$idPrefix}Mode" value="0" />

<ul id="{$idPrefix}ReferenceList">
{if isset($item) && (is_array($item) || is_object($item)) && isset($item.id)}
{assign var='idPrefixItem' value="`$idPrefix`Reference_`$item.id`"}
<li id="{$idPrefixItem}">
    {$item->getTitleFromDisplayPattern()}
     <a id="{$idPrefixItem}Remove" href="javascript:weeklyRemoveRelatedItem('{$idPrefix}', '{$item.id}');">{$removeImage}</a>
    <br />
    {if $item.locationPicture ne '' && isset($item.locationPictureFullPath) && $item.locationPictureMeta.isImage}
        {thumb image=$item.locationPictureFullPath objectid="location-`$item.id`" preset=$relationThumbPreset tag=true img_alt=$item->getTitleFromDisplayPattern()}
    {/if}
</li>
{/if}
</ul>
