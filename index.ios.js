import {NativeModules} from 'react-native';


const {BBBCardIO} = NativeModules;

const functions = {
  getCreditCardInfo() {
    return new Promise(function(resolve, reject) {
      BBBCardIO.getCreditCardInfo((data) => {
        if (data) {
          let [cardNumber, expiryMonth, expiryYear, cvv] = data.split(',');
          resolve({cardNumber, expiryMonth, expiryYear, cvv})
        } else {
          reject();
        }
      });
    });
  },
};

let exported = {};
Object.assign(exported, functions);

module.exports = exported;
