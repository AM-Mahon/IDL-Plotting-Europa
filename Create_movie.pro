pro Create_movie
  COMMON parameters,$
  nx,ny,nz,dx,dy,delz,$
  nt,dt,nout,$
  Ni_max,$
  m_pu,$
  alpha,beta,$
  b0_init,$
  nf_init,$
  vsw,vth,$
  RIo,$
  dir_root,filenom
  ;----------------------------------------
  dir_root='/Users/jama3001/Data/' ;Base folder (User specific)
  filenom= '2019-Fri-Sep-06/pluto-1/'  ;Date and run number (Dynamic)
  Read_para
  dir = dir_root + filenom+'data/grid/'
  read,'How many processors?',num_proc
  read,'How many frames?',num_frame
  Read_coord,x,y,z,dz_grid,dz_cell
  ct = colortable(72)
  center_proc = ceil(num_proc/2.0)
  
  ;MAGNETIC FIELD X

  Read_vector_3d, dir, 'c.b1_3d_8', 1, mag_3d
  max_bx = max(mag_3d[*,*,ceil(nz/2.0), 0])
  min_bx = min(mag_3d[*,*,ceil(nz/2.0), 0])
  for i = 2, num_frame do begin
    Read_vector_3d, dir, 'c.b1_3d_8', i, mag_3d
    step_max = max(mag_3d[*,*,ceil(nz/2.0), 0])
    step_min = min(mag_3d[*,*,ceil(nz/2.0), 0])
    if(step_max gt max_bx) then begin
      max_bx = step_max
    endif
    if(step_min lt min_bx) then begin
      min_bx = step_min
    endif
  endfor
  
  for i = 1,num_frame do begin
    Read_vector_3d, dir, 'c.b1_3d_8', i, mag_3d
    mag_2d = mag_3d[*,*,ceil(nz/2.0), 0] ;bx
    c_mag = contour(mag_2d, /fill, RGB_TABLE=ct, aspect_ratio=1.0, /buffer, MAX_VALUE=max_bx, MIN_VALUE=min_bx)
    cb_mag = colorbar(target=c_mag, orientation=1, title='bx')
    if(i eq 1) then begin
      c_mag.save, 'bFieldX.gif'
    endif else if(i lt num_frame) then begin
      c_mag.save, 'bFieldX.gif', /APPEND
    endif else begin
      c_mag.save, 'bFieldX.gif', /APPEND, /CLOSE
    endelse
  endfor
  
  ;MAGNETIC FIELD Y

  Read_vector_3d, dir, 'c.b1_3d_8', 1, mag_3d
  max_by = max(mag_3d[*,*,ceil(nz/2.0), 1])
  min_by = min(mag_3d[*,*,ceil(nz/2.0), 1])
  for i = 2, num_frame do begin
    Read_vector_3d, dir, 'c.b1_3d_8', i, mag_3d
    step_max = max(mag_3d[*,*,ceil(nz/2.0), 1])
    step_min = min(mag_3d[*,*,ceil(nz/2.0), 1])
    if(step_max gt max_by) then begin
      max_by = step_max
    endif
    if(step_min lt min_by) then begin
      min_by = step_min
    endif
  endfor

  for i = 1,num_frame do begin
    Read_vector_3d, dir, 'c.b1_3d_8', i, mag_3d
    mag_2d = mag_3d[*,*,ceil(nz/2.0), 1] ;bz
    c_mag = contour(mag_2d, /fill, RGB_TABLE=ct, aspect_ratio=1.0, /buffer, MAX_VALUE=max_by, MIN_VALUE=min_by)
    cb_mag = colorbar(target=c_mag, orientation=1, title='by')
    if(i eq 1) then begin
      c_mag.save, 'bFieldY.gif'
    endif else if(i lt num_frame) then begin
      c_mag.save, 'bFieldY.gif', /APPEND
    endif else begin
      c_mag.save, 'bFieldY.gif', /APPEND, /CLOSE
    endelse
  endfor

  ;MAGNETIC FIELD Z

  Read_vector_3d, dir, 'c.b1_3d_8', 1, mag_3d
  max_bz = max(mag_3d[*,*,ceil(nz/2.0), 2])
  min_bz = min(mag_3d[*,*,ceil(nz/2.0), 2])
  for i = 2, num_frame do begin
    Read_vector_3d, dir, 'c.b1_3d_8', i, mag_3d
    step_max = max(mag_3d[*,*,ceil(nz/2.0), 2])
    step_min = min(mag_3d[*,*,ceil(nz/2.0), 2])
    if(step_max gt max_bz) then begin
      max_bz = step_max
    endif
    if(step_min lt min_bz) then begin
      min_bz = step_min
    endif
  endfor

  for i = 1,num_frame do begin
    Read_vector_3d, dir, 'c.b1_3d_8', i, mag_3d
    mag_2d = mag_3d[*,*,ceil(nz/2.0), 2] ;bz
    c_mag = contour(mag_2d, /fill, RGB_TABLE=ct, aspect_ratio=1.0, /buffer, MAX_VALUE=max_bz, MIN_VALUE=min_bz)
    cb_mag = colorbar(target=c_mag, orientation=1, title='bz')
    if(i eq 1) then begin
      c_mag.save, 'bFieldZ.gif'
    endif else if(i lt num_frame) then begin
      c_mag.save, 'bFieldZ.gif', /APPEND
    endif else begin
      c_mag.save, 'bFieldZ.gif', /APPEND, /CLOSE
    endelse
  endfor

  ;VELOCITY

  Read_vector_3d, dir, 'c.up_3d_8', 1, vlc_3d
  max_v = max(vlc_3d[*,*,ceil(nz/2.0), 0])
  min_v = min(vlc_3d[*,*,ceil(nz/2.0), 0])
  for i = 2, num_frame do begin
    Read_vector_3d, dir, 'c.b1_3d_8', i, vlc_3d
    step_max = max(vlc_3d[*,*,ceil(nz/2.0), 0])
    step_min = min(vlc_3d[*,*,ceil(nz/2.0), 0])
    if(step_max gt max_v) then begin
      max_v = step_max
    endif
    if(step_min lt min_v) then begin
      min_v = step_min
    endif
  endfor

  for i = 1,num_frame do begin
    Read_vector_3d, dir, 'c.up_3d_8', i, vlc_3d
    vlc_2d = vlc_3d[*,*,ceil(nz/2.0), 0] ;vx
    c_vlc = contour(vlc_2d, /fill, RGB_TABLE=ct, aspect_ratio=1.0, /buffer, MAX_VALUE=max_v, MIN_VALUE=min_v)
    cb_vlc = colorbar(target=c_vlc, orientation=1, title='velocity')
    if(i eq 1) then begin
      c_vlc.save, 'velocity.gif'
    endif else if(i lt num_frame) then begin
      c_vlc.save, 'velocity.gif', /APPEND
    endif else begin
      c_vlc.save, 'velocity.gif', /APPEND, /CLOSE
    endelse
  endfor
  
  ;DENSITY

  Read_scalar_3d, dir, 'c.np_3d_8', 1, density_3d
  max_d = max(density_3d[*,*,ceil(nz/2.0)])
  min_d = min(density_3d[*,*,ceil(nz/2.0)])
  for i = 2, num_frame do begin
    Read_scalar_3d, dir, 'c.np_3d_8', i, density_3d
    step_max = max(density_3d[*,*,ceil(nz/2.0)])
    step_min = min(density_3d[*,*,ceil(nz/2.0)])
    if(step_max gt max_d) then begin
      max_d = step_max
    endif
    if(step_min lt min_d) then begin
      min_d = step_min
    endif
  endfor

  for i = 1,num_frame do begin
    Read_scalar_3d, dir, 'c.np_3d_8', i, density_3d

    density_2d = density_3d[*,*,ceil(nz/2.0)]
    c_density = contour(density_2d, /fill,RGB_TABLE=ct, aspect_ratio=1.0, /buffer, MAX_VALUE=max_d, MIN_VALUE=min_d)
    cb_density = colorbar(target=c_density, orientation=1, title = 'density')
    if(i eq 1) then begin 
      c_density.save, 'density.gif'
    endif else if(i lt num_frame) then begin
      c_density.save, 'density.gif', /APPEND
    endif else begin
      c_density.save, 'density.gif', /APPEND, /CLOSE
    endelse
    
  endfor
  
  ;TEMPERATURE

  Read_scalar_3d, dir, 'c.temp_p_3d_8', 1, temp_3d
  max_t = max(temp_3d[*,*,ceil(nz/2.0)])
  min_t = min(temp_3d[*,*,ceil(nz/2.0)])
  for i = 2, num_frame do begin
    Read_scalar_3d, dir, 'c.temp_p_3d_8', i, temp_3d
    step_max = max(temp_3d[*,*,ceil(nz/2.0)])
    step_min = min(temp_3d[*,*,ceil(nz/2.0)])
    if(step_max gt max_t) then begin
      max_t = step_max
    endif
    if(step_min lt min_t) then begin
      min_t = step_min
    endif
  endfor

  for i = 1,num_frame do begin
    Read_scalar_3d, dir, 'c.temp_p_3d_8', i, temp_3d

    temp_2d = temp_3d[*,*,ceil(nz/2.0)]
    c_temp = contour(temp_2d, /fill, RGB_TABLE=ct, aspect_ratio=1.0, /buffer, MAX_VALUE=max_t, MIN_VALUE=min_t)
    cb_temp = colorbar(target=c_temp, orientation=1, title='temp')
    if(i eq 1) then begin
      c_temp.save, 'temp.gif'
    endif else if(i lt num_frame) then begin
      c_temp.save, 'temp.gif', /APPEND
    endif else begin
      c_temp.save, 'temp.gif', /APPEND, /CLOSE
    endelse

  endfor
  
  
  print, "done"
  
  
end