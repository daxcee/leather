import Footer from './Footer.js';
import React from 'react';
import { Component } from 'react';
import { Link } from 'react-router';

class ForgotPassword extends Component {
  render() {
    return (
      <div>
        <div className="container is-fullhd">
          <div
            className="columns is-mobile is-centered"
            style={{ margin: '50px 0 60px 0' }}
          >
            <div className="column is-half is-narrow">
              <h1 className="title">Forgot password</h1>
              <div className="field">
                <label className="label">Email</label>
                <div className="control has-icons-left has-icons-right">
                  <input className="input" type="text" />
                  <span className="icon is-small is-left">
                    <i className="fa fa-envelope" />
                  </span>
                </div>
              </div>
              <div className="field is-grouped">
                <div className="control">
                  <button className="button is-primary">Submit</button>
                </div>
                <div className="control">
                  <Link className="button is-link" to="/login">Login</Link>
                  <Link className="button is-link" to="/signup">Signup</Link>
                </div>
              </div>
            </div>
          </div>
        </div>
        <Footer />
      </div>
    );
  }
}

export default ForgotPassword;
