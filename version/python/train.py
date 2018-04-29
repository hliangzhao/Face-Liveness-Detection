"""
The module for training the SVM classifer.
"""


def train(database_num=3):
    """
    use SVM provided by sklearn with databases to train the classifier and
    dump it into a pickle.

    :param database_num: 3 means NUAA, CASIA, REPLAY-ATTACK;
                         2 means CASIA, REPLAY-ATTACK.
    """
