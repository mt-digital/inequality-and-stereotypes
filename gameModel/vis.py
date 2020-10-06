import matplotlib.pyplot as plt
import pandas as pd


def plot_replication(data_path='replication.csv'):

    df = pd.read_csv(data_path)

    # Put columns in desired order.
    cols = ['Gendered', 'Women low', 'Both medium', 'Women high',
            'Non-maximizing', 'Mixed/not converged']

    df.index = df.Gendered

    df = df[cols[1:]]

    df.plot.bar(figsize=(6.5, 3.5))

    plt.ylabel('Frequency of outcome (% of total)')

    plt.savefig('../../Proposals/SPRF/Figures/demo_replication.pdf')
