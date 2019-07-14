import numpy as np
import matplotlib.pyplot as plt

dt = 1/20.
dtype = np.float32
C = np.array([[1, 0, 0, 0],
              [0, 1, 0, 0]], dtype = dtype)

A = np.array([[1, 0, dt, 0],
              [0, 1, 0, dt],
              [0, 0, 1, 0],
              [0, 0, 0, 1]], dtype = dtype)

Q = np.array([[0, 0, 0, 0],
              [0, 0, 0, 0],
              [0, 0, 1, 0],
              [0, 0, 0, 1]], dtype = dtype)
R = 10*np.eye(2)

x = np.zeros((4, 100))
y = np.zeros((2, 100))
x[:, 0] = np.random.randn(4)

for k in range(100):
    x[:, k] = A.dot(x[:, k-1]) + np.concatenate((np.zeros(2), np.random.randn(2)), axis=0)
    y[:, k] = C.dot(x[:, k]) + 1*np.random.randn(2)

x_est = np.zeros((4, 100))
P_est = np.eye(4)
I = np.eye(4)
x_est[:, 0] = x[:, 0]
for k in range(1, 100):
    P_pred = (A.dot(P_est)).dot(A.transpose()) + Q
    x_pred = A.dot(x_est[:, k-1])
    num = P_pred.dot(C.transpose())
    denum = (C.dot(P_pred)).dot(C.transpose()) + R
    K = num.dot(np.linalg.inv(denum))
    IKC = (I - K.dot(C))
    KRK = (K.dot(R)).dot(K.transpose())
    P_est = (IKC.dot(P_pred)).dot(IKC.transpose())+KRK
    x_est[:, k] = x_pred + K.dot(y[:, k]-C.dot(x_pred))




plt.plot(x[0, :])
plt.plot(y[0, :])
plt.plot(x_est[0, :])
plt.show()
plt.plot(x[1, :])
plt.plot(y[1, :])
plt.plot(x_est[1, :])
plt.show()