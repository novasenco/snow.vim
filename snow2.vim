
" I hope this cheers you up, habamax :)

function!s:snow(...)abort
  redraw
  let winw=winwidth('')
  let winh=winheight('')
  let firstwinw=winw
  let snr=a:0?str2nr(a:1):200
  let [xps,yps,xvs,yvs,xas,yas]=[[],[],[],[],[],[]]
  let tree='     ^         ^^^       ^^^^^      ^^^^^     ^^^|^^^   ^ ^^|^^ ^ ^^ ^|^|^ ^^    |||    '
  let pileh=8
  let piles=[]
  let wind=0
  for _ in range(pileh)
    call add(piles, repeat([0], winw))
  endfor
  let snow_=repeat([repeat(' ',winw)],winh)
  for _ in range(rand()%3+2)
    let x = rand()%(winw-8)
    let y = winh-rand()%8-9
    for j in range(8)
      for i in range(11)
        let ch = tree[i+j*11]
        if ch is ' '
          continue
        endif
        let snow_[y+j]=strcharpart(snow_[y+j],0,x+i-1)..ch..strcharpart(snow_[y+j],x+i)
      endfor
    endfor
  endfor
  for _ in range(snr)
    call add(xps,rand()%winw+0.0)
    call add(yps,0.0)
    call add(xvs,rand()%4+1.0)
    call add(yvs,rand()/4.294967e9-0.1)
    call add(xas,rand()/8.589935e9-0.25)
    call add(yas,rand()/8.589935e9-0.25)
  endfor
  silent tabnew
  setlocal buftype=nofile nolist nowrap colorcolumn= nolazyredraw
  syntax match SnowTree "\^"
  syntax match SnowTreeTrunk "|"
  highlight! link SnowTree String
  highlight! link SnowTreeTrunk Comment
  file Snow
  while !getchar(0)
    let winw=winwidth('')
    let winh=winheight('')
    let snow=copy(snow_)
    for i in range(snr)
      let y=float2nr(yps[i])
      let x=float2nr(xps[i])
      if y<0
        continue
      endif
      let snow[y]=strcharpart(snow[y],0,max([0,x-1]))..'*'..strcharpart(snow[y],max([1,x]))
      let xas[i]=rand()/8.589935e9-0.25
      let yas[i]=rand()/8.589935e9-0.25
      let xvs[i]=xvs[i]+xas[i]<-1.0?-1.0:xvs[i]+xas[i]>1.0?1.0:xvs[i]+xas[i]
      let yvs[i]=yvs[i]+yas[i]<-0.1?-0.1:yvs[i]+yas[i]>1.0?1.0:yvs[i]+yas[i]
      let xps[i]+=xvs[i]
      let yps[i]+=yvs[i]
      if xps[i]+xvs[i]<0
        let xps[i]=winw+0.0
      endif
      if xps[i]+xvs[i]>winw
        let xps[i]=0.0
      endif
      if yps[i]+yvs[i]>winh
        let yps[i]=0.0
        let xps[i]=rand()%winw+0.0
        let yvs[i]=rand()/8.589935e9-0.25
      elseif yps[i]>winh-pileh&&rand()%(pileh*10)<pileh
        let piles[min([pileh-1,float2nr(winh-yps[i])])][min([winw-1,float2nr(xps[i])])]+=rand()%100+100
        let xps[i]=0.0
        let xps[i]=rand()%winw+0.0
        let yvs[i]=rand()/8.589935e9-0.25
      endif
    endfor
    for i in range(winw)
      for j in range(pileh)
        if piles[j][i]
          let piles[j][i]-=1
          if snow[winh-pileh+j][i]is' '
            let snow[winh-pileh+j]=strcharpart(snow[winh-pileh+j],0,i)..'*'..strcharpart(snow[winh-pileh+j],i+1)
          endif
        endif
      endfor
    endfor
    silent%delete
    silent put=l:snow
    silent1delete
    normal!0
    sleep50m
    redraw
  endwhile
  if bufname()is'Snow'
    silent bwipeout
  endif
endfunction
command!-nargs=? Snow call<sid>snow(<f-args>)
":jJzVDy8e\\!\/l7.GY odb035LsP2^h]H|WgaN)O\"nrKTt=FE69x,vwu4mkqZpM[A(Rc*Sf_'X+BC>I1<U?iQ"
"XxrH]c3VkMbvWJZyE\\P\/mj\"2'tAG 94<!w86pu=*[NFiqsn,dBo0.DO7|C(1ReITSY:?+)Ul_a>KgzfQ^Lh5"
