import React, { useState, useRef, useEffect, forwardRef, useImperativeHandle } from "react";
import { useSelector, useDispatch } from 'react-redux'
import { useNavigate, Link } from 'react-router-dom'
import { Sidebar, Menu, MenuItem, useProSidebar, SubMenu } from 'react-pro-sidebar';
import { Icon } from "icon-picker-react";
import { FaHome, FaRegBuilding, FaGavel, FaYenSign, FaRegClone, FaUniversity, FaCog, FaUsers, FaHistory } from "react-icons/fa";
import {BsMenuButtonWideFill} from "react-icons/bs"
import {FiTrendingUp} from "react-icons/fi"
import styled from 'styled-components';

import styles from "./SideMenu.module.scss"
import { useResize, checkMobileDevice } from "./../../utils/Helper"
import { useLaravelReactI18n } from 'laravel-react-i18n'

import {
  startAction,
  endAction,
  showToast
} from '../../actions/common'
import { logout } from "../../actions/auth";
import agent from '../../api/'

const StyledSidebar = styled(Sidebar)`
  height: 100vh;
  color: #fff;
  border: none!important;

  &.ps-broken {
    z-index: 1029 !important;
    &>div {
      box-shadow: none;
    }
  }

  &.ps-collapsed .ps-submenu-expand-icon > span{
    display: inline-block;
    -webkit-transition: -webkit-transform 0.3s;
    transition: transform 0.3s;
    border-right: 2px solid currentcolor;
    border-bottom: 2px solid currentcolor;
    width: 7px;
    height: 7px;
    -webkit-transform: rotate(-45deg);
    -moz-transform: rotate(-45deg);
    -ms-transform: rotate(-45deg);
    transform: rotate(-45deg);
    border-radius: 0;
    background-color: transparent;
  }

  &>div {
    color: #a9b7d0;
    box-shadow: 1px 0 20px 0 #3f4d67;

    &::-webkit-scrollbar {
      width: 5px;
    }
    
    &::-webkit-scrollbar-track {
      // background-color: rgb(245, 81, 17);
      // background-color: transparent;
      border-radius: 100px;
    }
    
    &::-webkit-scrollbar-thumb {
      border-radius      : 100px;
      background-clip    : content-box;
      // background-color: rgba(255, 255, 255, 0.1);
      background-color   : #3f4d67;
      transition: background-color .2s linear,width .2s ease-in-out;
      -webkit-transition: background-color .2s linear,width .2s ease-in-out;
    }

    &:hover {
      &::-webkit-scrollbar-thumb {
        background-color   : #9C9EA1;
      }
    }
  }
`

const StyledSubMenu = styled(SubMenu)`
  border: none;
  border-left: 3px solid transparent;
  user-select: none;

  &.ps-open {
    border-left-color: #1dc4e9;

    &>a {
      background-color: #333F54;
      color: #fff;
      &:hover {
        background: #333F54;
        color: #fff;
      }
    }
  }
  &:hover {
    background: transparent;
  }
  &>a {
    .ps-menu-icon {
      font-size: 18px;
      justify-content: flex-start;
      width: auto;
      min-width: auto;
      margin-right: 14px;
    }
    .ps-submenu-expand-icon>span {
      width: 7px;
      height: 7px;
    }
  }
  &>a:hover {
    background: transparent!important;
    color: #1dc4e9;
  }
  &>div {
    background: #39465E;
  }
`

const StyledTopMenuItem = styled(MenuItem)`
  user-select: none;

  &:hover {
    background: transparent;
  }

  &>a:hover {
    background: transparent!important;
    color: #fff;
  }

  &:first-child > a{
    height: 70px;

    &:hover {
      cursor: default;
    }
  }
`;

const StyledMenuItem = styled(MenuItem)`
  border: none;
  border-left: 3px solid transparent;
  user-select: none;

  &.ps-active > a {
    background: transparent;
    color: #1dc4e9;
  }

  &:hover {
    background: transparent;
  }
  &>a {
    .ps-menu-icon {
      font-size: 18px;
      justify-content: flex-start;
      width: auto;
      min-width: auto;
      margin-right: 14px;
    }

    .ps-submenu-expand-icon>span {
      width: 7px;
      height: 7px;
    }
  }

  &>a:hover {
    background: transparent!important;
    color: #1dc4e9;
  }
`;


let renderedMenu
const SideMenu = forwardRef((props, ref) => {

  const navigate = useNavigate()
  const dispatch = useDispatch()

  const sidebarRef = useRef(null);

  const { collapseSidebar, toggleSidebar, collapsed, toggled, broken, rtl } = useProSidebar();
  const { isMobile } = useResize()
  const { t, tChoice } = useLaravelReactI18n();

  const [menus, setMenus] = useState([])

  useImperativeHandle(ref, () => ({
    clickMobileMenu() {
      collapseSidebar(!props.clickedMobileMenu)
      props.setClickedMobileMenu((old) => !old)
    }
  }));

  // useEffect(() => {
  //   getMenuData()
  // }, [])

  // const getMenuData = async() => {
  //   dispatch(startAction())
  //   try {
  //     const res = await agent.common.getMenus()
  //     if(res.data.success) {
  //       let source = makeMenuSource(res.data.data)
  //       console.log('source=', source)
  //       setMenus([...source])
  //     }
  //     dispatch(endAction())
  //   } catch (error) {
  //     if (error.response.status >= 400 && error.response.status <= 500) {
  //       dispatch(endAction())
  //       dispatch(showToast('error', error.response.data.message))
  //       if (error.response.data.message == 'Unauthorized') {
  //         localStorage.removeItem('token')
  //         dispatch(logout())
  //         navigate('/')
  //       }
  //     }
  //   }
  // }

  // const makeRenderedMenu = (source) => {
  //   source.map((el) => {
  //     if(el.items != undefined && el.items != null) {
  //       const icon = el.icon != null ? <Icon icon={el.icon}/> : ''
  //       const component = el.route_url != null && el.route_url != '' ? <Link to={el.route_url} /> : ''
  //       return (
  //         <StyledSubMenu icon={icon} component={component} label={el.name}>
  //         {() => makeRenderedMenu(el.items)}
  //         </StyledSubMenu>
  //       )
  //     } else {
  //       const icon = el.icon != null ? <Icon icon={el.icon}/> : ''
  //       const component = el.route_url != null && el.route_url != '' ? <Link to={el.route_url} /> : ''
  //       return <StyledMenuItem icon={icon} component={component}>{el.name}</StyledMenuItem>
  //     }
  //   })
  // }

  // const makeMenuSource = (data) => {
  //   let menuDataSource = []
  //   data.map((m) => {
  //     if(m.parent_menu_id == 0) {
  //       menuDataSource.push({
  //         ...m
  //       })
  //     }
  //   })
  //   menuDataSource.sort((a, b) => {
  //     return a.menu_order - b.menu_order
  //   })

  //   data.map((m) => {
  //     if(m.parent_menu_id != 0) {
  //       insertMenuItem(menuDataSource, m)
  //     }
  //   })
  //   return menuDataSource
  // }

  // const insertMenuItem = (menuArray, menuItem) => {
  //   menuArray.map((menu, idx) => {
  //     if(menu.id == menuItem.parent_menu_id) {
  //       if(menuArray[idx].items == undefined || menuArray[idx].items == null) {
  //         menuArray[idx]['items'] = new Array()
  //       }
  //       menuArray[idx].items.push({
  //         ...menuItem
  //       })
  //       menuArray[idx].items.sort((a, b) => {
  //         return a.menu_order - b.menu_order
  //       })
  //       return
  //     }
  //     if(menu.items != undefined && menu.items != null) {
  //       insertMenuItem(menu.items, menuItem)
  //     }
  //   })
  //   return
  // }

  const toggle = () => {
    // toggleSidebar();
    if (toggled) {
      console.log(true);
      collapseSidebar();
    } else {
      console.log(false);
      collapseSidebar();
    }
  };

  // const clickMobileMenu = () => {
  //   props.setClickedMobileMenu((old) => !old)
  //   collapseSidebar(!props.clickedMobileMenu)
  // }

  const sidebarMouseEnter = () => {
    if(props.clickedMobileMenu && collapsed) {
      collapseSidebar()
    }
  }

  const sidebarMouseLeave = () => {
    if(props.clickedMobileMenu && !collapsed) {
      collapseSidebar()
    }
  }

  const sidebarClick = () => {
    if(checkMobileDevice()) {
      if(props.clickedMobileMenu && collapsed) {
        collapseSidebar()
      }
    }
  }

  return (
    <>
      <StyledSidebar 
        customBreakPoint="992px"
        rtl={false}
        // image="/assets/image/bg-sidebar.jpg"
        className={styles.side_menu}
        ref={sidebarRef}
        collapsedWidth="75px"
        onMouseEnter={() => sidebarMouseEnter()}
        onMouseLeave={() => sidebarMouseLeave()}
        onClick={() => sidebarClick()}
      >
        <Menu id="menu">
          {
            !isMobile &&
              <StyledTopMenuItem
                icon={<div className={styles.bg_trendingup}><FiTrendingUp /></div>}
              >
                <div className={styles.b_brand}>
                  <span className={styles.b_text}>{ t('Payment') }</span>
                  {
                    !collapsed &&
                      <div className={`${styles.mobile_menu} ${(props.clickedMobileMenu ? styles.on : '')}`} onClick={() => ref.current.clickMobileMenu()}><span></span></div>
                  }
                </div>
              </StyledTopMenuItem>
          }
          {/* {
            () => makeRenderedMenu(menus)
          } */}
          <StyledMenuItem icon={<FaHome/>} component={<Link to="/article" />}>{ t('Object Management') }</StyledMenuItem>
          <StyledMenuItem icon={<FaRegBuilding />} component={<Link to="/company" />}>{ t('Vendor Management') }</StyledMenuItem>
          <StyledSubMenu icon={<FaGavel />} label={ t('Construction Management') }>
            <StyledMenuItem component={<Link to="/construction/1" />}>{ t('Housing construction list') }</StyledMenuItem>
            <StyledMenuItem component={<Link to="/construction/0" />}>{ t('Building construction list') }</StyledMenuItem>
          </StyledSubMenu>
          <StyledSubMenu icon={<FaYenSign />} label={ t('Input Management') }>
            <StyledMenuItem component={<Link to="/payment" />}>{ t('Input confirmation') }</StyledMenuItem>
            <StyledMenuItem component={<Link to="/transfer" />}>{ t('Payment confirmation') }</StyledMenuItem>
          </StyledSubMenu>
          <StyledSubMenu icon={<FaRegClone />} label={ t('Summing') }>
            <StyledMenuItem component={<Link to="/aggregates/all" />} >{ t('Whole') }</StyledMenuItem>
            <StyledMenuItem component={<Link to="/aggregates/constructions" />} >{ t('Annual A3') }</StyledMenuItem>
            <StyledMenuItem component={<Link to="/aggregates/constructions-month" />} >{ t('Monthly A4') }</StyledMenuItem>
          </StyledSubMenu>
          <StyledMenuItem icon={<FaUniversity />} component={<Link to="/zengin" />}>{ t('Bank format output') }</StyledMenuItem>
          <StyledMenuItem icon={<FaCog />} component={<Link to="/setting" />}>{ t('Setting') }</StyledMenuItem>
          <StyledMenuItem icon={<FaUsers />} component={<Link to="/users" />}>{ t('User Management') }</StyledMenuItem>
          <StyledMenuItem icon={<FaHistory />} component={<Link to="/logs" />}>{ t('Log view') }</StyledMenuItem>
          <StyledMenuItem icon={<BsMenuButtonWideFill />} component={<Link to="/menu" />}>{ t('Menu setting') }</StyledMenuItem>
        </Menu>
      </StyledSidebar>
    </>
  );
})

export default SideMenu