# Python
import tensorflow as tf
hello = tf.constant('\n\n Hello, TensorFlow!\n\n')
sess = tf.Session()
print(sess.run(hello))
