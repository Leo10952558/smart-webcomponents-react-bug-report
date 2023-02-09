import React, { useState, useEffect } from 'react';
import { useSelector, useDispatch } from 'react-redux'
import { Link, useNavigate } from 'react-router-dom'
import { useProSidebar } from 'react-pro-sidebar';
import { BsKey } from "react-icons/bs";
import { SlLock, SlUser, SlLogout } from "react-icons/sl";
import { FiMaximize, FiMinimize, FiSettings, FiLogOut, FiUser, FiTrendingUp } from "react-icons/fi";

import styles from './Header.module.scss';

import {
  startAction,
  endAction,
  showToast
} from '../../actions/common'
import {
  login,
  logout
} from '../../actions/auth'
import { useResize, checkMobileDevice } from "../../utils/Helper"
import agent from '../../api/'

import { useLaravelReactI18n } from 'laravel-react-i18n'

const Header = (props) => {
  const { t, tChoice } = useLaravelReactI18n();

  const dispatch = useDispatch()
  const navigate = useNavigate()

  const auth = useSelector(state => state.auth)
  const { collapseSidebar, toggleSidebar, collapsed, toggled, broken, rtl } = useProSidebar()

  const [showUserBox, setShowUserBox] = useState(false)
  const [fullscreen, setFullscreen] = useState(false)

  const { isMobile } = useResize()

  const  goInFullscreen = (el) => {
    if(el.requestFullscreen)
      el.requestFullscreen();
    else if(el.mozRequestFullScreen)
      el.mozRequestFullScreen();
    else if(el.webkitRequestFullscreen)
      el.webkitRequestFullscreen();
    else if(el.msRequestFullscreen)
      el.msRequestFullscreen();
  }

  const  goOutFullscreen = () => {
    if(document.exitFullscreen)
      document.exitFullscreen();
    else if(document.mozCancelFullScreen)
      document.mozCancelFullScreen();
    else if(document.webkitExitFullscreen)
      document.webkitExitFullscreen();
    else if(document.msExitFullscreen)
      document.msExitFullscreen();
  }

  const clickFullscreen = () => {
    if(fullscreen) {
      setFullscreen(false)
      goOutFullscreen()
    } else {
      setFullscreen(true)
      const rootElement = document.getElementById('root')
      goInFullscreen(rootElement)
    }
  }

  const submitLogout = async() => {
    dispatch(startAction())
		const res = await agent.auth.logout()
		if (res.data.success) {
      dispatch(showToast('success', res.data.message))
      localStorage.removeItem('token')
      dispatch(logout())
      navigate("/")
    } else dispatch(showToast('error', res.data.message))
		dispatch(endAction())
  }

  return (
    <header style={{marginLeft: 0, width: '100%'}} className="navbar pcoded-header navbar-expand-lg header-default">
      {
        isMobile && 
        <div className={`collapse navbar-collapse ${styles.mobile_header}`}>
          <ul className="navbar-nav mr-auto">
            <li className={styles.left_container}>
              <div className={styles.bg_trendingup}>
                <FiTrendingUp />
              </div>
              <div className={styles.payment_text}>
                Payment
              </div>
            </li>
          </ul>
          <ul className={`navbar-nav ml-auto ${styles.right_btn}`}>
            <li className={styles.right_container}>
              <div className="drp-user dropdown">
                <div className={`${styles.mobile_menu} ${(props.clickedMobileMenu ? styles.on : '')}`} onClick={() => toggleSidebar()}><span></span></div>
              </div>
            </li>
          </ul>
        </div>
      }
      <div className="collapse navbar-collapse">
        <ul className="navbar-nav mr-auto">
          <li>
            {
              fullscreen ?
                <a className="full-screen" onClick={() => clickFullscreen()}><FiMinimize/></a>
                :
                <a className="full-screen" onClick={() => clickFullscreen()}><FiMaximize/></a>
            }
          </li>
        </ul>
        <ul className="navbar-nav ml-auto">
          <li>
            <div className="drp-user dropdown">
              <button onClick={() => setShowUserBox((old) => !old)} aria-haspopup="true" aria-expanded="true" id="dropdown-basic" type="button" className="dropdown-toggle btn btn-link" style={{paddingRight: '5px'}}><FiSettings/></button>
              {
                showUserBox &&
                  <div aria-labelledby='dropdown-basic' className='profile-notification dropdown-menu show dropdown-menu-right' x-placement='bottom-end' style={{position: 'absolute', willChange: 'transform', top: 0, left: 0, transform: 'translate3d(-249px, 70px, 0px)'}}>
                    <div className='pro-head'>
                      <span>{auth.currentUser.first_name + ' ' + auth.currentUser.last_name}</span>
                      <a className="dud-logout" title="Logout" onClick={() => submitLogout()}><FiLogOut/></a>
                    </div>
                    <ul className="pro-body">
                      <li><Link className='dropdown-item' to={'/profile'} onClick={() => setShowUserBox(false)}><FiUser />&nbsp;&nbsp;&nbsp;&nbsp;{ t('Profile') }</Link></li>
                      <li><Link className='dropdown-item' to={'/changePassword'} onClick={() => setShowUserBox(false)}><BsKey />&nbsp;&nbsp;&nbsp;&nbsp;{ t('Change Password') }</Link></li>
                    </ul>
                  </div>
              }
            </div>
          </li>
        </ul>
      </div>
    </header>
  );
}

export default Header