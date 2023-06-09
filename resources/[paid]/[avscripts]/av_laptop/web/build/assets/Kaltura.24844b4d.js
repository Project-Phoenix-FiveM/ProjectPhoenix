import{v as E,r as C}from"./index.75547906.js";import{p as W,u as A}from"./VolumeOff.40e60d42.js";function N(s,l){for(var y=0;y<l.length;y++){const f=l[y];if(typeof f!="string"&&!Array.isArray(f)){for(const p in f)if(p!=="default"&&!(p in s)){const d=Object.getOwnPropertyDescriptor(f,p);d&&Object.defineProperty(s,p,d.get?d:{enumerable:!0,get:()=>f[p]})}}}return Object.freeze(Object.defineProperty(s,Symbol.toStringTag,{value:"Module"}))}var g={};(function(s){function l(e){return typeof Symbol=="function"&&typeof Symbol.iterator=="symbol"?l=function(n){return typeof n}:l=function(n){return n&&typeof Symbol=="function"&&n.constructor===Symbol&&n!==Symbol.prototype?"symbol":typeof n},l(e)}Object.defineProperty(s,"__esModule",{value:!0}),s.default=void 0;var y=O(C.exports),f=A,p=W;function d(){if(typeof WeakMap!="function")return null;var e=new WeakMap;return d=function(){return e},e}function O(e){if(e&&e.__esModule)return e;if(e===null||l(e)!=="object"&&typeof e!="function")return{default:e};var r=d();if(r&&r.has(e))return r.get(e);var n={},t=Object.defineProperty&&Object.getOwnPropertyDescriptor;for(var o in e)if(Object.prototype.hasOwnProperty.call(e,o)){var u=t?Object.getOwnPropertyDescriptor(e,o):null;u&&(u.get||u.set)?Object.defineProperty(n,o,u):n[o]=e[o]}return n.default=e,r&&r.set(e,n),n}function b(e,r){if(!(e instanceof r))throw new TypeError("Cannot call a class as a function")}function P(e,r){for(var n=0;n<r.length;n++){var t=r[n];t.enumerable=t.enumerable||!1,t.configurable=!0,"value"in t&&(t.writable=!0),Object.defineProperty(e,t.key,t)}}function w(e,r,n){return r&&P(e.prototype,r),n&&P(e,n),e}function S(e,r){if(typeof r!="function"&&r!==null)throw new TypeError("Super expression must either be null or a function");e.prototype=Object.create(r&&r.prototype,{constructor:{value:e,writable:!0,configurable:!0}}),r&&v(e,r)}function v(e,r){return v=Object.setPrototypeOf||function(t,o){return t.__proto__=o,t},v(e,r)}function R(e){var r=L();return function(){var t=h(e),o;if(r){var u=h(this).constructor;o=Reflect.construct(t,arguments,u)}else o=t.apply(this,arguments);return D(this,o)}}function D(e,r){return r&&(l(r)==="object"||typeof r=="function")?r:c(e)}function c(e){if(e===void 0)throw new ReferenceError("this hasn't been initialised - super() hasn't been called");return e}function L(){if(typeof Reflect>"u"||!Reflect.construct||Reflect.construct.sham)return!1;if(typeof Proxy=="function")return!0;try{return Date.prototype.toString.call(Reflect.construct(Date,[],function(){})),!0}catch{return!1}}function h(e){return h=Object.setPrototypeOf?Object.getPrototypeOf:function(n){return n.__proto__||Object.getPrototypeOf(n)},h(e)}function a(e,r,n){return r in e?Object.defineProperty(e,r,{value:n,enumerable:!0,configurable:!0,writable:!0}):e[r]=n,e}var T="https://cdn.embed.ly/player-0.1.0.min.js",k="playerjs",_=function(e){S(n,e);var r=R(n);function n(){var t;b(this,n);for(var o=arguments.length,u=new Array(o),i=0;i<o;i++)u[i]=arguments[i];return t=r.call.apply(r,[this].concat(u)),a(c(t),"callPlayer",f.callPlayer),a(c(t),"duration",null),a(c(t),"currentTime",null),a(c(t),"secondsLoaded",null),a(c(t),"mute",function(){t.callPlayer("mute")}),a(c(t),"unmute",function(){t.callPlayer("unmute")}),a(c(t),"ref",function(m){t.iframe=m}),t}return w(n,[{key:"componentDidMount",value:function(){this.props.onMount&&this.props.onMount(this)}},{key:"load",value:function(o){var u=this;(0,f.getSDK)(T,k).then(function(i){!u.iframe||(u.player=new i.Player(u.iframe),u.player.on("ready",function(){setTimeout(function(){u.player.isReady=!0,u.player.setLoop(u.props.loop),u.props.muted&&u.player.mute(),u.addListeners(u.player,u.props),u.props.onReady()},500)}))},this.props.onError)}},{key:"addListeners",value:function(o,u){var i=this;o.on("play",u.onPlay),o.on("pause",u.onPause),o.on("ended",u.onEnded),o.on("error",u.onError),o.on("timeupdate",function(m){var K=m.duration,M=m.seconds;i.duration=K,i.currentTime=M})}},{key:"play",value:function(){this.callPlayer("play")}},{key:"pause",value:function(){this.callPlayer("pause")}},{key:"stop",value:function(){}},{key:"seekTo",value:function(o){this.callPlayer("setCurrentTime",o)}},{key:"setVolume",value:function(o){this.callPlayer("setVolume",o)}},{key:"setLoop",value:function(o){this.callPlayer("setLoop",o)}},{key:"getDuration",value:function(){return this.duration}},{key:"getCurrentTime",value:function(){return this.currentTime}},{key:"getSecondsLoaded",value:function(){return this.secondsLoaded}},{key:"render",value:function(){var o={width:"100%",height:"100%"};return y.default.createElement("iframe",{ref:this.ref,src:this.props.url,frameBorder:"0",scrolling:"no",style:o,allow:"encrypted-media; autoplay; fullscreen;",referrerPolicy:"no-referrer-when-downgrade"})}}]),n}(y.Component);s.default=_,a(_,"displayName","Kaltura"),a(_,"canPlay",p.canPlay.kaltura)})(g);const j=E(g),V=N({__proto__:null,default:j},[g]);export{V as K};
