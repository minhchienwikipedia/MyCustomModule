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
  componentDidMount() {
    // Register event
    this.addListener = myCustomModuleEmitter.addListener('addEvent', event =>
      this.setState({ data: JSON.stringify(event) })
    );
  }

  componentWillUnmount() {
    this.addListener.remove();
  }
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
          placeholder="Type..."
          value={val}
          underlineColorAndroid="transparent"
          onChangeText={val =>
            this.setState({
              val
            })
          }
        />
        <Text
          style={styles.text}
          onPress={() =>
            MyCustomModule.hello(val, data => this.setState({ data }))
          }
        >
          Say Hi
        </Text>
        <Text
          style={styles.text}
          onPress={() =>
            MyCustomModule.isString(val)
              .then(data => this.setState({ data: data }))
              .catch(data => this.setState({ data: data.message }))
          }
        >
          Check is string
        </Text>
        <Text
          style={styles.text}
          onPress={() =>
            MyCustomModule.getInfo(
              'Iphone',
              4,
              300.012,
              true,
              [1, 'two', 'three'],
              {
                id: 321321,
                name: 'Minh Chien',
                age: 23
              },
              data => this.setState({ data: JSON.stringify(data) })
            )
          }
        >
          Get Info
        </Text>
        <Text
          style={styles.text}
          onPress={() =>
            MyCustomModule.addEvent('addEvent', {
              value: val.toString(),
              time: new Date().toISOString()
            })
          }
        >
          Add Event
        </Text>

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
  },
  text: { marginTop: 20, color: '#47A4E0', fontSize: 20 }
});
