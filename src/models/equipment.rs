use serde::{Deserialize, Serialize};
use surrealdb::types::SurrealValue;


#[derive(SurrealValue, Serialize, Deserialize)]
pub struct EquipmentFamily {
    eqp_id: String,
    loc_at: String,
    rptdb_at: String,
    area_id: String,
    is_active: bool,
    e10_code: String,
    state_code: String,
}

#[derive(SurrealValue, Serialize, Deserialize)]
pub struct Equipment {
    eqp_id: String,
    loc_at: String,
    rptdb_at: String,
    area_id: String,
    is_active: bool,
    e10_code: String,
    state_code: String,
}

pub struct Chamber {
    chamber_id: String,
    loc_at: String,
    rptdb_at: String,
    eqp_id: String,
    name: String,
    is_active: bool,
    e10_code: String,
    state_code: String,
}

// #[derive(Debug, toasty::Model)]
// #[table = "tools"]
// #[key(name = "pk_tools", eqp_id)]
// pub struct Tool {
//     #[column(type = varchar(32))]
//     eqp_id: String,
//     #[column(type = varchar(32))]
//     loc_at: String,
//     #[column(type = varchar(32))]
//     rptdb_at: String,
//     #[column(type = varchar(32))]
//     area_id: String,
//     is_active: bool,
//     #[column(type = varchar(8))]
//     e10_code: String,
//     #[column(type = varchar(16))]
//     state_code: String,
// }

// #[derive(Debug, toasty::Model)]
// #[table = "chambers"]
// #[key(name = "pk_chambers", chamber_id)]
// pub struct Chamber {
//     #[column(type = varchar(96))]
//     chamber_id: String,
//     #[column(type = varchar(32))]
//     loc_at: String,
//     #[column(type = varchar(32))]
//     rptdb_at: String,
//     #[column(type = varchar(32))]
//     eqp_id: String,
//     name: String,
//     is_active: bool,
//     #[column(type = varchar(8))]
//     e10_code: String,
//     #[column(type = varchar(16))]
//     state_code: String,
// }

// #[derive(Debug, toasty::Model)]
// #[table = "tools_state_tracking"]
// #[key(name = "pk_tools_state_tracking", partition=state_start, local=eqp_id)]
// pub struct ToolStateTracking {
//     #[column(type = varchar(32))]
//     eqp_id: String,
//     #[column(type = varchar(8))]
//     e10_code: String,
//     #[column(type = varchar(16))]
//     state_code: String,
//     #[column(type = varchar(8))]
//     new_e10_code: Option<String>,
//     #[column(type = varchar(16))]
//     new_state_code: Option<String>,
//     state_start: jiff::Timestamp,
//     state_end: Option<jiff::Timestamp>,
//     #[default(jiff::Timestamp::now())]
//     created_at: jiff::Timestamp,
//     #[update(jiff::Timestamp::now())]
//     updated_at: jiff::Timestamp,
// }

// #[derive(Debug, toasty::Model)]
// #[table = "chambers_state_tracking"]
// #[key(name = "pk_chambers_state_tracking", partition=state_start, local=chamber_id)]
// pub struct ChamberStateTracking {
//     #[column(type = varchar(96))]
//     chamber_id: String,
//     #[column(type = varchar(32))]
//     eqp_id: String,
//     #[column(type = varchar(32))]
//     name: String,
//     #[column(type = varchar(8))]
//     e10_code: String,
//     #[column(type = varchar(16))]
//     state_code: String,
//     #[column(type = varchar(8))]
//     new_e10_code: Option<String>,
//     #[column(type = varchar(16))]
//     new_state_code: Option<String>,
//     state_start: jiff::Timestamp,
//     state_end: Option<jiff::Timestamp>,
//     active: Option<bool>,
//     #[default(jiff::Timestamp::now())]
//     created_at: jiff::Timestamp,
//     #[update(jiff::Timestamp::now())]
//     updated_at: jiff::Timestamp,
// }
