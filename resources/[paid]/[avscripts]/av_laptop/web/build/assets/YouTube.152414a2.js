import{v as fe,r as ce}from"./index.75547906.js";import{p as se,u as ye}from"./VolumeOff.40e60d42.js";function pe(h,p){for(var v=0;v<p.length;v++){const l=p[v];if(typeof l!="string"&&!Array.isArray(l)){for(const d in l)if(d!=="default"&&!(d in h)){const m=Object.getOwnPropertyDescriptor(l,d);m&&Object.defineProperty(h,d,m.get?m:{enumerable:!0,get:()=>l[d]})}}}return Object.freeze(Object.defineProperty(h,Symbol.toStringTag,{value:"Module"}))}var j={};(function(h){function p(e){return typeof Symbol=="function"&&typeof Symbol.iterator=="symbol"?p=function(n){return typeof n}:p=function(n){return n&&typeof Symbol=="function"&&n.constructor===Symbol&&n!==Symbol.prototype?"symbol":typeof n},p(e)}Object.defineProperty(h,"__esModule",{value:!0}),h.default=void 0;var v=$(ce.exports),l=ye,d=se;function m(){if(typeof WeakMap!="function")return null;var e=new WeakMap;return m=function(){return e},e}function $(e){if(e&&e.__esModule)return e;if(e===null||p(e)!=="object"&&typeof e!="function")return{default:e};var t=m();if(t&&t.has(e))return t.get(e);var n={},r=Object.defineProperty&&Object.getOwnPropertyDescriptor;for(var a in e)if(Object.prototype.hasOwnProperty.call(e,a)){var u=r?Object.getOwnPropertyDescriptor(e,a):null;u&&(u.get||u.set)?Object.defineProperty(n,a,u):n[a]=e[a]}return n.default=e,t&&t.set(e,n),n}function M(e,t){var n=Object.keys(e);if(Object.getOwnPropertySymbols){var r=Object.getOwnPropertySymbols(e);t&&(r=r.filter(function(a){return Object.getOwnPropertyDescriptor(e,a).enumerable})),n.push.apply(n,r)}return n}function I(e){for(var t=1;t<arguments.length;t++){var n=arguments[t]!=null?arguments[t]:{};t%2?M(Object(n),!0).forEach(function(r){y(e,r,n[r])}):Object.getOwnPropertyDescriptors?Object.defineProperties(e,Object.getOwnPropertyDescriptors(n)):M(Object(n)).forEach(function(r){Object.defineProperty(e,r,Object.getOwnPropertyDescriptor(n,r))})}return e}function N(e,t){return H(e)||F(e,t)||G(e,t)||K()}function K(){throw new TypeError(`Invalid attempt to destructure non-iterable instance.
In order to be iterable, non-array objects must have a [Symbol.iterator]() method.`)}function G(e,t){if(!!e){if(typeof e=="string")return Y(e,t);var n=Object.prototype.toString.call(e).slice(8,-1);if(n==="Object"&&e.constructor&&(n=e.constructor.name),n==="Map"||n==="Set")return Array.from(e);if(n==="Arguments"||/^(?:Ui|I)nt(?:8|16|32)(?:Clamped)?Array$/.test(n))return Y(e,t)}}function Y(e,t){(t==null||t>e.length)&&(t=e.length);for(var n=0,r=new Array(t);n<t;n++)r[n]=e[n];return r}function F(e,t){if(!(typeof Symbol>"u"||!(Symbol.iterator in Object(e)))){var n=[],r=!0,a=!1,u=void 0;try{for(var i=e[Symbol.iterator](),o;!(r=(o=i.next()).done)&&(n.push(o.value),!(t&&n.length===t));r=!0);}catch(f){a=!0,u=f}finally{try{!r&&i.return!=null&&i.return()}finally{if(a)throw u}}return n}}function H(e){if(Array.isArray(e))return e}function W(e,t){if(!(e instanceof t))throw new TypeError("Cannot call a class as a function")}function V(e,t){for(var n=0;n<t.length;n++){var r=t[n];r.enumerable=r.enumerable||!1,r.configurable=!0,"value"in r&&(r.writable=!0),Object.defineProperty(e,r.key,r)}}function x(e,t,n){return t&&V(e.prototype,t),n&&V(e,n),e}function z(e,t){if(typeof t!="function"&&t!==null)throw new TypeError("Super expression must either be null or a function");e.prototype=Object.create(t&&t.prototype,{constructor:{value:e,writable:!0,configurable:!0}}),t&&U(e,t)}function U(e,t){return U=Object.setPrototypeOf||function(r,a){return r.__proto__=a,r},U(e,t)}function q(e){var t=J();return function(){var r=D(e),a;if(t){var u=D(this).constructor;a=Reflect.construct(r,arguments,u)}else a=r.apply(this,arguments);return Z(this,a)}}function Z(e,t){return t&&(p(t)==="object"||typeof t=="function")?t:g(e)}function g(e){if(e===void 0)throw new ReferenceError("this hasn't been initialised - super() hasn't been called");return e}function J(){if(typeof Reflect>"u"||!Reflect.construct||Reflect.construct.sham)return!1;if(typeof Proxy=="function")return!0;try{return Date.prototype.toString.call(Reflect.construct(Date,[],function(){})),!0}catch{return!1}}function D(e){return D=Object.setPrototypeOf?Object.getPrototypeOf:function(n){return n.__proto__||Object.getPrototypeOf(n)},D(e)}function y(e,t,n){return t in e?Object.defineProperty(e,t,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[t]=n,e}var Q="https://www.youtube.com/iframe_api",B="YT",X="onYouTubeIframeAPIReady",E=/[?&](?:list|channel)=([a-zA-Z0-9_-]+)/,C=/user\/([a-zA-Z0-9_-]+)\/?/,ee=/youtube-nocookie\.com/,te="https://www.youtube-nocookie.com",L=function(e){z(n,e);var t=q(n);function n(){var r;W(this,n);for(var a=arguments.length,u=new Array(a),i=0;i<a;i++)u[i]=arguments[i];return r=t.call.apply(t,[this].concat(u)),y(g(r),"callPlayer",l.callPlayer),y(g(r),"parsePlaylist",function(o){if(o instanceof Array)return{listType:"playlist",playlist:o.map(r.getID).join(",")};if(E.test(o)){var f=o.match(E),c=N(f,2),_=c[1];return{listType:"playlist",list:_.replace(/^UC/,"UU")}}if(C.test(o)){var O=o.match(C),w=N(O,2),P=w[1];return{listType:"user_uploads",list:P}}return{}}),y(g(r),"onStateChange",function(o){var f=o.data,c=r.props,_=c.onPlay,O=c.onPause,w=c.onBuffer,P=c.onBufferEnd,A=c.onEnded,S=c.onReady,R=c.loop,T=c.config,b=T.playerVars,k=T.onUnstarted,s=window[B].PlayerState,re=s.UNSTARTED,ne=s.PLAYING,ae=s.PAUSED,oe=s.BUFFERING,ie=s.ENDED,ue=s.CUED;if(f===re&&k(),f===ne&&(_(),P()),f===ae&&O(),f===oe&&w(),f===ie){var le=!!r.callPlayer("getPlaylist");R&&!le&&(b.start?r.seekTo(b.start):r.play()),A()}f===ue&&S()}),y(g(r),"mute",function(){r.callPlayer("mute")}),y(g(r),"unmute",function(){r.callPlayer("unMute")}),y(g(r),"ref",function(o){r.container=o}),r}return x(n,[{key:"componentDidMount",value:function(){this.props.onMount&&this.props.onMount(this)}},{key:"getID",value:function(a){return!a||a instanceof Array||E.test(a)?null:a.match(d.MATCH_URL_YOUTUBE)[1]}},{key:"load",value:function(a,u){var i=this,o=this.props,f=o.playing,c=o.muted,_=o.playsinline,O=o.controls,w=o.loop,P=o.config,A=o.onError,S=P.playerVars,R=P.embedOptions,T=this.getID(a);if(u){if(E.test(a)||C.test(a)||a instanceof Array){this.player.loadPlaylist(this.parsePlaylist(a));return}this.player.cueVideoById({videoId:T,startSeconds:(0,l.parseStartTime)(a)||S.start,endSeconds:(0,l.parseEndTime)(a)||S.end});return}(0,l.getSDK)(Q,B,X,function(b){return b.loaded}).then(function(b){!i.container||(i.player=new b.Player(i.container,I({width:"100%",height:"100%",videoId:T,playerVars:I(I({autoplay:f?1:0,mute:c?1:0,controls:O?1:0,start:(0,l.parseStartTime)(a),end:(0,l.parseEndTime)(a),origin:window.location.origin,playsinline:_?1:0},i.parsePlaylist(a)),S),events:{onReady:function(){w&&i.player.setLoop(!0),i.props.onReady()},onPlaybackRateChange:function(s){return i.props.onPlaybackRateChange(s.data)},onStateChange:i.onStateChange,onError:function(s){return A(s.data)}},host:ee.test(a)?te:void 0},R)))},A),R.events&&console.warn("Using `embedOptions.events` will likely break things. Use ReactPlayer\u2019s callback props instead, eg onReady, onPlay, onPause")}},{key:"play",value:function(){this.callPlayer("playVideo")}},{key:"pause",value:function(){this.callPlayer("pauseVideo")}},{key:"stop",value:function(){!document.body.contains(this.callPlayer("getIframe"))||this.callPlayer("stopVideo")}},{key:"seekTo",value:function(a){this.callPlayer("seekTo",a),this.props.playing||this.pause()}},{key:"setVolume",value:function(a){this.callPlayer("setVolume",a*100)}},{key:"setPlaybackRate",value:function(a){this.callPlayer("setPlaybackRate",a)}},{key:"setLoop",value:function(a){this.callPlayer("setLoop",a)}},{key:"getDuration",value:function(){return this.callPlayer("getDuration")}},{key:"getCurrentTime",value:function(){return this.callPlayer("getCurrentTime")}},{key:"getSecondsLoaded",value:function(){return this.callPlayer("getVideoLoadedFraction")*this.getDuration()}},{key:"render",value:function(){var a=this.props.display,u={width:"100%",height:"100%",display:a};return v.default.createElement("div",{style:u},v.default.createElement("div",{ref:this.ref}))}}]),n}(v.Component);h.default=L,y(L,"displayName","YouTube"),y(L,"canPlay",d.canPlay.youtube)})(j);const de=fe(j),ge=pe({__proto__:null,default:de},[j]);export{ge as Y};
