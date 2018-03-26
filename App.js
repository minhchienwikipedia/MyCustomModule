/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * @flow
 */

import React, { Component } from 'react';
import {
  Platform,
  StyleSheet,
  Text,
  View,
  Button,
  NativeEventEmitter,
  TextInput
} from 'react-native';
import MyCustomModule from './components/MyCustomModule';

const myCustomModuleEmitter = new NativeEventEmitter(MyCustomModule);

const instructions = Platform.select({
  ios: 'Press Cmd+R to reload,\n' + 'Cmd+D or shake for dev menu',
  android:
    'Double tap R on your keyboard to reload,\n' +
    'Shake or press menu button for dev menu'
});

type Props = {};
export default class App extends Component<Props> {
  state = {
    data: '',
    val: ''
  };
  render() {
    const { data, val } = this.state;
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>Welcome to My MyCustomModule!</Text>

        <TextInput
          style={{
            width: 200,
            height: 40,
            borderBottomColor: 'gray',
            borderBottomWidth: 1
          }}
          value={val}
          onChangeText={val =>
            this.setState({
              val
            })
          }
        />
        <Button
          title="Say Hello"
          onPress={() =>
            MyCustomModule.hello(val, data => this.setState({ data }))
          }
        />
        <Button
          title="Check is string"
          onPress={() =>
            MyCustomModule.isString(val)
              .then(data =>
                this.setState({ data: data }, () =>
                  console.log('2) promise resolved')
                )
              )
              .catch(data =>
                this.setState({ data: data.message }, () =>
                  console.log('2) promise rejected')
                )
              )
          }
        />
        <Text>{data}</Text>
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF'
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5
  }
});
