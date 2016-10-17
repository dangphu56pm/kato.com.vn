/*! mediabox v1.1.1 | (c) 2016 Pedro Rogerio | https://github.com/pinceladasdaweb/mediabox */
!function(e,t){"use strict";"function"==typeof define&&define.amd?define([],t):"object"==typeof exports?module.exports=t():e.MediaBox=t()}(this,function(){"use strict";var e=function(t){return this&&this instanceof e?t?(this.selector=t instanceof NodeList?t:document.querySelectorAll(t),this.root=document.querySelector("body"),void this.run()):!1:new e(t)};return e.prototype={run:function(){Array.prototype.forEach.call(this.selector,function(e){e.addEventListener("click",function(t){t.preventDefault();var i=this.parseUrl(e.getAttribute("href"));this.render(i),this.events()}.bind(this),!1)}.bind(this)),this.root.addEventListener("keyup",function(e){27===(e.keyCode||e.which)&&this.close(this.root.querySelector(".mediabox-wrap"))}.bind(this),!1)},template:function(e,t){var i;for(i in t)t.hasOwnProperty(i)&&(e=e.replace(new RegExp("{"+i+"}","g"),t[i]));return e},parseUrl:function(e){var t,i={};return(t=e.match(/^.*(youtu.be\/|v\/|u\/\w\/|embed\/|watch\?v=)([^#\&\?]*).*/))?(i.provider="youtube",i.id=t[2]):(t=e.match(/https?:\/\/(?:www\.)?vimeo.com\/(?:channels\/|groups\/([^\/]*)\/videos\/|album\/(\d+)\/video\/|)(\d+)(?:$|\/|\?)/))?(i.provider="vimeo",i.id=t[3]):(i.provider="Unknown",i.id=""),i},render:function(e){var t,i;if("youtube"===e.provider)t="https://www.youtube.com/embed/"+e.id;else{if("vimeo"!==e.provider)throw new Error("Invalid video URL");t="https://player.vimeo.com/video/"+e.id}i=this.template('<div class="mediabox-wrap" role="dialog" aria-hidden="false"><div class="mediabox-content" role="document" tabindex="0"><span class="mediabox-close" aria-label="close"></span><iframe src="{embed}?autoplay=1" frameborder="0" allowfullscreen></iframe></div></div>',{embed:t}),this.root.insertAdjacentHTML("beforeend",i)},events:function(){var e=document.querySelector(".mediabox-wrap");e.addEventListener("click",function(t){(t.target&&"SPAN"===t.target.nodeName&&"mediabox-close"===t.target.className||"DIV"===t.target.nodeName&&"mediabox-wrap"===t.target.className)&&this.close(e)}.bind(this),!1)},close:function(e){var t=null;t&&clearTimeout(t),e.classList.add("mediabox-hide"),t=setTimeout(function(){this.root.removeChild(e)}.bind(this),500)}},e});
MediaBox('.mediabox');