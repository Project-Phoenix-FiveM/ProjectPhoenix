import{c as x,r,j as s,a as e,T as l,d as S,N as n}from"./index.75547906.js";import{R as C,d as v,a as k,S as z}from"./VolumeOff.40e60d42.js";import{B as t}from"./Button.359114d2.js";import"./index.7998e83e.js";import"./shouldSpreadAdditionalProps.f803cff9.js";import"./visuallyHidden.f7ffa40e.js";const m=x({palette:{primary:{main:"rgba(255,255,255,1)"},secondary:{main:"rgba(255,255,255,0.7)"},playing:{main:"rgba(255, 255, 255,0.4)"}}}),R=({song:c="https://soundcloud.com/s_kane/hesit-song",show:d})=>{const[p,y]=r.exports.useState(!0),[a,h]=r.exports.useState(!1),[i,o]=r.exports.useState(.25),u=(M,b)=>{o(b)},g=()=>{h(!a),n("miniplayer",a)},f=()=>{d(!1),n("miniplayer","close")};return s("div",{className:"mini-player-container",style:{height:a?"50px":"150px"},children:[e("div",{className:"mini-player-main",children:e(C,{url:c,height:a?0:100,width:450,playing:p,volume:i,onReady:()=>{y(!0)},style:{marginTop:"6px"}})}),e("div",{className:"mini-player-controls",children:s(l,{theme:m,children:[i<=0?e(v,{color:"secondary",fontSize:"small",style:{marginTop:"2%"}}):e(k,{color:"secondary",fontSize:"small",onClick:()=>{o(0)},style:{marginTop:"2%"}}),e(z,{"aria-label":"Volume",value:i,onChange:u,min:0,max:1,step:.01,size:"small",style:{marginLeft:"2%",width:"50%",paddingTop:"5px"},sx:{"& .MuiSlider-track":{border:"none"},"& .MuiSlider-thumb":{backgroundColor:"#fff","&:before":{boxShadow:"0 2px 4px rgba(0,0,0,0.4)"},"&:hover, &.Mui-focusVisible, &.Mui-active":{boxShadow:"none"}}}}),e(S,{color:"secondary",fontSize:"small",style:{marginTop:"2%",marginLeft:"4%"},onClick:()=>{o(1)}})]})}),e("div",{className:"mini-player-btns",children:s(l,{theme:m,children:[e(t,{color:"primary",style:{backgroundColor:"rgba(50,155,50,1)"},onClick:g,children:a?"Maximize":"Minimize"}),e(t,{color:"primary",style:{backgroundColor:"rgba(155,50,50,1)"},onClick:f,children:"Close"})]})})]})};export{R as default};
