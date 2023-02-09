import React, {useState, useRef} from 'react';
import { Outlet } from 'react-router-dom';

import SideMenu from '../SideMenu';
import Header from '../Header';

import styles from './SideLayout.module.scss';

const SideLayout = () => {

  const ref = useRef();

  const [clickedMobileMenu, setClickedMobileMenu] = useState(false);

  const clickBtn = () => {
    ref.current.clickMobileMenu()
  }

  return (
    <div id="app" className={styles.app}>
      <SideMenu ref={ref} clickedMobileMenu={clickedMobileMenu} setClickedMobileMenu={setClickedMobileMenu}/>
      <main className={styles.main}>
        <Header clickBtn={clickBtn} clickedMobileMenu={clickedMobileMenu}/>
        <div className="pcoded-wrapper">
          <div className="pcoded-content">
            <div className="pcoded-inner-content">
              <Outlet />
            </div>
          </div>
        </div>
      </main>
    </div>
  );
}

export default SideLayout