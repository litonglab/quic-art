from maze_env import ART_RL
from RL_brain import DeepQNetwork


def run_maze():
    step = 0
    while True:
        # fresh env
        try:
            observation = env.render()

            # RL choose action based on observation
            action = RL.choose_action(observation)

            # write action to shared memory

            # RL take action and lsquic to step and generate next observation and reward
            # observation_, reward, done = env.step(action)
            # RL.store_transition(observation, action, reward, observation_)

            if (step > 200) and (step % 5 == 0):
                RL.learn()

            # observation should be sample from state
            # observation = observation_

            step += 1
        except KeyboardInterrupt:
            RL.save_net()

if __name__ == "__main__":
    # maze game
    env = ART_RL()
    RL = DeepQNetwork(env.n_actions, env.n_features,
                      learning_rate=0.01,
                      reward_decay=0.9,
                      e_greedy=0.9,
                      replace_target_iter=200,
                      memory_size=2000,
                      # output_graph=True
                      env=env
                      )
    run_maze()

