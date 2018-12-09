"use strict";
const fs=require("fs");
const out=x=>fs.writeSync(1,x,null,"binary");
let t=fs.readFileSync(0,"binary");
let v,s;
while(v=/^((?:[^\\\/]|\\[^])*)\/((?:[^\\\/]|\\[^])*)\/((?:[^\\\/]|\\[^])*)\//.exec(t)) {
  t=t.slice(v[0].length);
  v=v.map(x=>x.replace(/\\([^])/g,"$1"));
  out(v[1]);
  s=true;
  while(s) s=false,t=t.replace(v[2],()=>(s=true,v[3]));
}
out(t.replace(/\\([^])/g,(y,x)=>x=="/"?"\u012F":x).replace(/\/[^]*$/,""));

// http://zzo38computer.org/textfile/miscellaneous/slashes.js
