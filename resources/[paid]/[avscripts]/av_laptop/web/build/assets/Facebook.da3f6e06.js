import{v as T,r as x}from"./index.75547906.js";import{p as B,u as C}from"./VolumeOff.40e60d42.js";function K(c,l){for(var p=0;p<l.length;p++){const i=l[p];if(typeof i!="string"&&!Array.isArray(i)){for(const f in i)if(f!=="default"&&!(f in c)){const y=Object.getOwnPropertyDescriptor(i,f);y&&Object.defineProperty(c,f,y.get?y:{enumerable:!0,get:()=>i[f]})}}}return Object.freeze(Object.defineProperty(c,Symbol.toStringTag,{value:"Module"}))}var P={};(function(c){function l(e){return typeof Symbol=="function"&&typeof Symbol.iterator=="symbol"?l=function(n){return typeof n}:l=function(n){return n&&typeof Symbol=="function"&&n.constructor===Symbol&&n!==Symbol.prototype?"symbol":typeof n},l(e)}Object.defineProperty(c,"__esModule",{value:!0}),c.default=void 0;var p=k(x.exports),i=C,f=B;function y(){if(typeof WeakMap!="function")return null;var e=new WeakMap;return y=function(){return e},e}function k(e){if(e&&e.__esModule)return e;if(e===null||l(e)!=="object"&&typeof e!="function")return{default:e};var t=y();if(t&&t.has(e))return t.get(e);var n={},r=Object.defineProperty&&Object.getOwnPropertyDescriptor;for(var a in e)if(Object.prototype.hasOwnProperty.call(e,a)){var u=r?Object.getOwnPropertyDescriptor(e,a):null;u&&(u.get||u.set)?Object.defineProperty(n,a,u):n[a]=e[a]}return n.default=e,t&&t.set(e,n),n}function m(){return m=Object.assign||function(e){for(var t=1;t<arguments.length;t++){var n=arguments[t];for(var r in n)Object.prototype.hasOwnProperty.call(n,r)&&(e[r]=n[r])}return e},m.apply(this,arguments)}function R(e,t){if(!(e instanceof t))throw new TypeError("Cannot call a class as a function")}function O(e,t){for(var n=0;n<t.length;n++){var r=t[n];r.enumerable=r.enumerable||!1,r.configurable=!0,"value"in r&&(r.writable=!0),Object.defineProperty(e,r.key,r)}}function E(e,t,n){return t&&O(e.prototype,t),n&&O(e,n),e}function I(e,t){if(typeof t!="function"&&t!==null)throw new TypeError("Super expression must either be null or a function");e.prototype=Object.create(t&&t.prototype,{constructor:{value:e,writable:!0,configurable:!0}}),t&&_(e,t)}function _(e,t){return _=Object.setPrototypeOf||function(r,a){return r.__proto__=a,r},_(e,t)}function L(e){var t=F();return function(){var r=b(e),a;if(t){var u=b(this).constructor;a=Reflect.construct(r,arguments,u)}else a=r.apply(this,arguments);return M(this,a)}}function M(e,t){return t&&(l(t)==="object"||typeof t=="function")?t:d(e)}function d(e){if(e===void 0)throw new ReferenceError("this hasn't been initialised - super() hasn't been called");return e}function F(){if(typeof Reflect>"u"||!Reflect.construct||Reflect.construct.sham)return!1;if(typeof Proxy=="function")return!0;try{return Date.prototype.toString.call(Reflect.construct(Date,[],function(){})),!0}catch{return!1}}function b(e){return b=Object.setPrototypeOf?Object.getPrototypeOf:function(n){return n.__proto__||Object.getPrototypeOf(n)},b(e)}function s(e,t,n){return t in e?Object.defineProperty(e,t,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[t]=n,e}var D="https://connect.facebook.net/en_US/sdk.js",S="FB",w="fbAsyncInit",A="facebook-player-",h=function(e){I(n,e);var t=L(n);function n(){var r;R(this,n);for(var a=arguments.length,u=new Array(a),o=0;o<a;o++)u[o]=arguments[o];return r=t.call.apply(t,[this].concat(u)),s(d(r),"callPlayer",i.callPlayer),s(d(r),"playerID",r.props.config.playerId||"".concat(A).concat((0,i.randomString)())),s(d(r),"mute",function(){r.callPlayer("mute")}),s(d(r),"unmute",function(){r.callPlayer("unmute")}),r}return E(n,[{key:"componentDidMount",value:function(){this.props.onMount&&this.props.onMount(this)}},{key:"load",value:function(a,u){var o=this;if(u){(0,i.getSDK)(D,S,w).then(function(v){return v.XFBML.parse()});return}(0,i.getSDK)(D,S,w).then(function(v){v.init({appId:o.props.config.appId,xfbml:!0,version:o.props.config.version}),v.Event.subscribe("xfbml.render",function(g){o.props.onLoaded()}),v.Event.subscribe("xfbml.ready",function(g){g.type==="video"&&g.id===o.playerID&&(o.player=g.instance,o.player.subscribe("startedPlaying",o.props.onPlay),o.player.subscribe("paused",o.props.onPause),o.player.subscribe("finishedPlaying",o.props.onEnded),o.player.subscribe("startedBuffering",o.props.onBuffer),o.player.subscribe("finishedBuffering",o.props.onBufferEnd),o.player.subscribe("error",o.props.onError),o.props.muted?o.callPlayer("mute"):o.callPlayer("unmute"),o.props.onReady(),document.getElementById(o.playerID).querySelector("iframe").style.visibility="visible")})})}},{key:"play",value:function(){this.callPlayer("play")}},{key:"pause",value:function(){this.callPlayer("pause")}},{key:"stop",value:function(){}},{key:"seekTo",value:function(a){this.callPlayer("seek",a)}},{key:"setVolume",value:function(a){this.callPlayer("setVolume",a)}},{key:"getDuration",value:function(){return this.callPlayer("getDuration")}},{key:"getCurrentTime",value:function(){return this.callPlayer("getCurrentPosition")}},{key:"getSecondsLoaded",value:function(){return null}},{key:"render",value:function(){var a=this.props.config.attributes,u={width:"100%",height:"100%"};return p.default.createElement("div",m({style:u,id:this.playerID,className:"fb-video","data-href":this.props.url,"data-autoplay":this.props.playing?"true":"false","data-allowfullscreen":"true","data-controls":this.props.controls?"true":"false"},a))}}]),n}(p.Component);c.default=h,s(h,"displayName","Facebook"),s(h,"canPlay",f.canPlay.facebook),s(h,"loopOnEnded",!0)})(P);const N=T(P),q=K({__proto__:null,default:N},[P]);export{q as F};
