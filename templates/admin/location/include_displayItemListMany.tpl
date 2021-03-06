{* purpose of this template: inclusion template for display of related locations in admin area *}
{if !isset($nolink)}
    {assign var='nolink' value=false}
{/if}
{if isset($items) && $items ne null && count($items) gt 0}
<ul class="weekly-related-item-list location">
{foreach name='relLoop' item='item' from=$items}
    <li>
{strip}
{if !$nolink}
    <a href="{modurl modname='Weekly' type='admin' func='display' ot='location' id=$item.id}" title="{$item->getTitleFromDisplayPattern()|replace:"\"":""}">
{/if}
    {$item->getTitleFromDisplayPattern()}
{if !$nolink}
    </a>
    <a id="locationItem{$item.id}Display" href="{modurl modname='Weekly' type='admin' func='display' ot='location' id=$item.id theme='Printer'}" title="{gt text='Open quick view window'}" class="z-hide">{icon type='view' size='extrasmall' __alt='Quick view'}</a>
{/if}
{/strip}
{if !$nolink}
<script type="text/javascript">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
        weeklyInitInlineWindow($('locationItem{{$item.id}}Display'), '{{$item->getTitleFromDisplayPattern()|replace:"'":""}}');
    });
/* ]]> */
</script>
{/if}
<br />
{if $item.locationPicture ne '' && isset($item.locationPictureFullPath) && $item.locationPictureMeta.isImage}
    {thumb image=$item.locationPictureFullPath objectid="location-`$item.id`" preset=$relationThumbPreset tag=true img_alt=$item->getTitleFromDisplayPattern()}
{/if}
    </li>
{/foreach}
</ul>
{/if}
