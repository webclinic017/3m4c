CREATE TABLE stock (
    id SERIAL PRIMARY KEY,
    symbol TEXT NOT NULL,
    name TEXT NOT NULL,
    exchange TEXT NOT NULL,
    is_etf BOOLEAN NOT NULL,
);

CREATE TABLE stock_price (
    stock_id INTEGER NOT NULL,
    dt TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    open NUMERIC NOT NULL,
    high NUMERIC NOT NULL,
    low NUMERIC NOT NULL,
    close NUMERIC NOT NULL,
    volume NUMERIC NOT NULL,
    PRIMARY KEY (stock_id, dt),
    CONSTRAINT fk_stock FOREIGN KEY (stock_id) REFERENCES stock (id)
);

CREATE INDEX ON stock_price (stock_id, dt DESC);
SELECT create_hypertable('stock_price', 'dt');

CREATE TABLE mention (
    stock_id INTEGER,
    stock_symbol TEXT NOT NULL,
    dt TIMESTAMP WITHOUT TIME ZONE NOT NULL,
    title TEXT NOT NULL,
    body TEXT NOT NULL,
    flair TEXT NOT NULL,
    post_id TEXT NOT NULL,
    score INTEGER NOT NULL,
    num_comments INTEGER NOT NULL,
    url TEXT NOT NULL,
    sentiment NUMERIC NOT NULL DEFAULT 0,
    PRIMARY KEY (stock_id, dt),
    CONSTRAINT fk_mention_stock FOREIGN KEY (stock_id) REFERENCES stock (id)
);

CREATE INDEX ON mention (stock_id, dt DESC);
SELECT create_hypertable('mention', 'dt');
