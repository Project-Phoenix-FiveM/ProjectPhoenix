import{g as p,b as k,w as N,H as P,I as G,_ as r,A as c,r as d,C as S,l as U,i as H,h as _,a as y,e as I,p as j}from"./index.75547906.js";import{L as $}from"./Select.4a83c0db.js";const A=p("MuiDivider",["root","absolute","fullWidth","inset","middle","flexItem","light","vertical","withChildren","withChildrenVertical","textAlignRight","textAlignLeft","wrapper","wrapperVertical"]),M=A,D=p("MuiListItemIcon",["root","alignItemsFlexStart"]),O=D;function Z(e){return k("MuiListItemText",e)}const W=p("MuiListItemText",["root","multiline","dense","inset","primary","secondary"]),L=W;function z(e){return k("MuiMenuItem",e)}const E=p("MuiMenuItem",["root","focusVisible","dense","disabled","divider","gutters","selected"]),n=E,h=["autoFocus","component","dense","divider","disableGutters","focusVisibleClassName","role","tabIndex","className"],q=(e,t)=>{const{ownerState:s}=e;return[t.root,s.dense&&t.dense,s.divider&&t.divider,!s.disableGutters&&t.gutters]},J=e=>{const{disabled:t,dense:s,divider:a,disableGutters:l,selected:u,classes:o}=e,i=j({root:["root",s&&"dense",t&&"disabled",!l&&"gutters",a&&"divider",u&&"selected"]},z,o);return r({},o,i)},K=N(P,{shouldForwardProp:e=>G(e)||e==="classes",name:"MuiMenuItem",slot:"Root",overridesResolver:q})(({theme:e,ownerState:t})=>r({},e.typography.body1,{display:"flex",justifyContent:"flex-start",alignItems:"center",position:"relative",textDecoration:"none",minHeight:48,paddingTop:6,paddingBottom:6,boxSizing:"border-box",whiteSpace:"nowrap"},!t.disableGutters&&{paddingLeft:16,paddingRight:16},t.divider&&{borderBottom:`1px solid ${(e.vars||e).palette.divider}`,backgroundClip:"padding-box"},{"&:hover":{textDecoration:"none",backgroundColor:(e.vars||e).palette.action.hover,"@media (hover: none)":{backgroundColor:"transparent"}},[`&.${n.selected}`]:{backgroundColor:e.vars?`rgba(${e.vars.palette.primary.mainChannel} / ${e.vars.palette.action.selectedOpacity})`:c(e.palette.primary.main,e.palette.action.selectedOpacity),[`&.${n.focusVisible}`]:{backgroundColor:e.vars?`rgba(${e.vars.palette.primary.mainChannel} / calc(${e.vars.palette.action.selectedOpacity} + ${e.vars.palette.action.focusOpacity}))`:c(e.palette.primary.main,e.palette.action.selectedOpacity+e.palette.action.focusOpacity)}},[`&.${n.selected}:hover`]:{backgroundColor:e.vars?`rgba(${e.vars.palette.primary.mainChannel} / calc(${e.vars.palette.action.selectedOpacity} + ${e.vars.palette.action.hoverOpacity}))`:c(e.palette.primary.main,e.palette.action.selectedOpacity+e.palette.action.hoverOpacity),"@media (hover: none)":{backgroundColor:e.vars?`rgba(${e.vars.palette.primary.mainChannel} / ${e.vars.palette.action.selectedOpacity})`:c(e.palette.primary.main,e.palette.action.selectedOpacity)}},[`&.${n.focusVisible}`]:{backgroundColor:(e.vars||e).palette.action.focus},[`&.${n.disabled}`]:{opacity:(e.vars||e).palette.action.disabledOpacity},[`& + .${M.root}`]:{marginTop:e.spacing(1),marginBottom:e.spacing(1)},[`& + .${M.inset}`]:{marginLeft:52},[`& .${L.root}`]:{marginTop:0,marginBottom:0},[`& .${L.inset}`]:{paddingLeft:36},[`& .${O.root}`]:{minWidth:36}},!t.dense&&{[e.breakpoints.up("sm")]:{minHeight:"auto"}},t.dense&&r({minHeight:32,paddingTop:4,paddingBottom:4},e.typography.body2,{[`& .${O.root} svg`]:{fontSize:"1.25rem"}}))),Q=d.exports.forwardRef(function(t,s){const a=S({props:t,name:"MuiMenuItem"}),{autoFocus:l=!1,component:u="li",dense:o=!1,divider:b=!1,disableGutters:i=!1,focusVisibleClassName:w,role:R="menuitem",tabIndex:f,className:T}=a,V=U(a,h),v=d.exports.useContext($),C=d.exports.useMemo(()=>({dense:o||v.dense||!1,disableGutters:i}),[v.dense,o,i]),g=d.exports.useRef(null);H(()=>{l&&g.current&&g.current.focus()},[l]);const B=r({},a,{dense:C.dense,divider:b,disableGutters:i}),m=J(a),F=_(g,s);let x;return a.disabled||(x=f!==void 0?f:-1),y($.Provider,{value:C,children:y(K,r({ref:F,role:R,tabIndex:x,component:u,focusVisibleClassName:I(m.focusVisible,w),className:I(m.root,T)},V,{ownerState:B,classes:m}))})}),ee=Q;export{ee as M,Z as g,L as l};
