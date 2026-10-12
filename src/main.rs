use std::env;

use anyhow::Result;
use axum::{Router, serve};
use dotenvy::dotenv;
use surrealdb::{Surreal, engine::local::SurrealKv};
use tokio::net::TcpListener;
use tracing_subscriber::{layer::SubscriberExt, util::SubscriberInitExt};

mod database;
mod error;
mod models;

#[tokio::main]
async fn main() -> Result<()> {
    dotenv()?;
    tracing_subscriber::registry()
        .with(
            tracing_subscriber::EnvFilter::try_from_default_env()
                .unwrap_or_else(|_| format!("{}=debug", env!("CARGO_CRATE_NAME")).into()),
        )
        .with(tracing_subscriber::fmt::layer())
        .init();
    let db = Surreal::new::<SurrealKv>("").await?;
    let app = Router::new().with_state(db);
    let listener = TcpListener::bind("127.0.0.1:3000").await.unwrap();
    tracing::debug!("listening on {}", listener.local_addr().unwrap());
    serve(listener, app).await?;

    Ok(())
}
