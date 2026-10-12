DEFINE NAMESPACE IF NOT EXISTS cim;
USE NS cim;
DEFINE DATABASE IF NOT EXISTS processx;
USE DB processx;

-- define equipment family
DEFINE TABLE IF NOT EXISTS equipment_family SCHEMAFULL COMMENT "机台家族";
-- DEFINE FIELD IF NOT EXISTS family_code ON equipment_family TYPE string;
DEFINE FIELD IF NOT EXISTS enabled ON equipment_family TYPE bool DEFAULT true;
DEFINE FIELD IF NOT EXISTS created_at ON equipment_family TYPE datetime DEFAULT time::now();
DEFINE FIELD IF NOT EXISTS updated_at ON equipment_family TYPE datetime DEFAULT time::now();
-- DEFINE INDEX IF NOT EXISTS pk_equipment_family ON equipment_family FIELDS family_code UNIQUE;

-- define equipment
DEFINE TABLE IF NOT EXISTS equipment SCHEMAFULL;
DEFINE FIELD IF NOT EXISTS e10_state_code ON equipment TYPE string 
    ASSERT $value in["PRD","SBY","ENG","SDT","UDT","NST"];
DEFINE FIELD IF NOT EXISTS e10_state_start ON equipment TYPE datetime;
DEFINE FIELD IF NOT EXISTS eqp_state_code ON equipment TYPE string;
DEFINE FIELD IF NOT EXISTS eqp_state_start ON equipment TYPE datetime;

-- define chamber
DEFINE TABLE IF NOT EXISTS chamber SCHEMAFULL;
DEFINE FIELD IF NOT EXISTS eqp_id ON chamber TYPE string;
DEFINE FIELD IF NOT EXISTS eqp_name ON chamber TYPE string;
DEFINE FIELD IF NOT EXISTS model ON chamber TYPE string;
DEFINE FIELD IF NOT EXISTS e10_state_code ON chamber TYPE string 
    ASSERT $value in["PRD","SBY","ENG","SDT","UDT","NST"];
DEFINE FIELD IF NOT EXISTS e10_state_start ON chamber TYPE datetime;
DEFINE FIELD IF NOT EXISTS eqp_state_code ON chamber TYPE string;
DEFINE FIELD IF NOT EXISTS eqp_state_start ON chamber TYPE datetime;


-- define route
DEFINE TABLE IF NOT EXISTS route SCHEMAFULL;
DEFINE FIELD IF NOT EXISTS route_id ON route TYPE string;
DEFINE FIELD IF NOT EXISTS route_name ON route TYPE option<string>;
DEFINE FIELD IF NOT EXISTS product_code ON route TYPE string;
DEFINE FIELD IF NOT EXISTS version_code ON recipe TYPE option<string>;
DEFINE FIELD IF NOT EXISTS enabled ON recipe TYPE bool DEFAULT true;
DEFINE FIELD IF NOT EXISTS process_steps ON route TYPE array<record<process_step>>;

DEFINE INDEX IF NOT EXISTS pk_route ON route FIELDS route_id UNIQUE;

-- define process_step
DEFINE TABLE IF NOT EXISTS process_step SCHEMAFULL;
DEFINE FIELD IF NOT EXISTS layer ON process_step TYPE string;
DEFINE FIELD IF NOT EXISTS ope_name ON process_step TYPE string;
DEFINE INDEX IF NOT EXISTS idx_process_step_layer ON process_step FIELDS layer;
DEFINE INDEX IF NOT EXISTS idx_process_step_name ON process_step FIELDS ope_name;

-- define recipe
DEFINE TABLE IF NOT EXISTS recipe SCHEMAFULL;
DEFINE FIELD IF NOT EXISTS recipe_id ON recipe TYPE string;
DEFINE FIELD IF NOT EXISTS recipe_name ON recipe TYPE option<string>;
DEFINE FIELD IF NOT EXISTS product_id ON recipe TYPE option<string>;
DEFINE FIELD IF NOT EXISTS ope_no ON recipe TYPE option<string>;
DEFINE FIELD IF NOT EXISTS version_code ON recipe TYPE option<string>;
DEFINE FIELD IF NOT EXISTS enabled ON recipe TYPE bool DEFAULT true;
DEFINE INDEX IF NOT EXISTS pk_recipe ON process_step FIELDS recipe_id UNIQUE;

--define lot
DEFINE TABLE IF NOT EXISTS lot SCHEMAFULL;
DEFINE FIELD IF NOT EXISTS lot_type ON lot TYPE string;
DEFINE FIELD IF NOT EXISTS sub_lot_type ON lot TYPE string;
DEFINE FIELD IF NOT EXISTS product_code ON lot TYPE string;
DEFINE FIELD IF NOT EXISTS route_id ON lot TYPE string;
DEFINE FIELD IF NOT EXISTS qty ON lot TYPE int;
DEFINE FIELD IF NOT EXISTS process_status ON lot TYPE string;
DEFINE FIELD IF NOT EXISTS ope_no ON lot TYPE option<string>;
DEFINE FIELD IF NOT EXISTS eqp_id ON lot TYPE option<string>;
DEFINE FIELD IF NOT EXISTS priority ON lot TYPE int;
DEFINE FIELD IF NOT EXISTS claim_time ON lot TYPE datetime;
DEFINE FIELD IF NOT EXISTS ope_category ON lot TYPE option<string>;
DEFINE FIELD IF NOT EXISTS ctrl_job ON lot TYPE string;

DEFINE INDEX IF NOT EXISTS pk_lot ON lot FIELDS lot_id UNIQUE;
DEFINE INDEX IF NOT EXISTS idx_lot_ope_no ON lot FIELDS ope_no;
DEFINE INDEX IF NOT EXISTS idx_lot_eqp ON lot FIELDS eqp_id;

-- define alarm
DEFINE TABLE IF NOT EXISTS alarm SCHEMAFULL;
DEFINE FIELD IF NOT EXISTS alarm_code ON alarm TYPE string;
DEFINE FIELD IF NOT EXISTS alarm_name ON alarm TYPE option<string>;
DEFINE FIELD IF NOT EXISTS serverity ON alarm TYPE string
    ASSERT $value IN ["INFO","WARN","ERROR","CRITICAL"];
DEFINE FIELD IF NOT EXISTS description ON alarm TYPE option<string>;
DEFINE FIELD IF NOT EXISTS alarm_start ON alarm TYPE datetime;
DEFINE FIELD IF NOT EXISTS alarm_end ON alarm TYPE option<datetime>;
DEFINE FIELD IF NOT EXISTS status ON alarm TYPE string
    ASSERT $value IN ["ACTIVE","CLEARED","ACK"]
DEFINE FIELD IF NOT EXISTS event_id ON alarm TYPE string;

DEFINE INDEX IF NOT EXISTS idx_alarm_code ON alarm FIELDS alarm_code;
DEFINE INDEX IF NOT EXISTS idx_alarm_status ON alarm FIELDS status;

DEFINE TABLE IF NOT EXISTS reticle SCHEMAFULL;
DEFINE FIELD IF NOT EXISTS reticle_id ON reticle TYPE string;
DEFINE FIELD IF NOT EXISTS location ON reticle TYPE string;


-- define relations
DEFINE TABLE IF NOT EXISTS belongs_to TYPE RELATION IN equipment OUT equipment_family SCHEMAFULL ENFORCED;
DEFINE TABLE IF NOT EXISTS can_process TYPE RELATION IN equipment OUT process_step SCHEMAFULL;
DEFINE TABLE IF NOT EXISTS use_recipe TYPE RELATION IN equipment OUT recipe SCHEMAFULL;
DEFINE TABLE IF NOT EXISTS has_step TYPE RELATION IN route OUT process_step SCHEMAFULL;
DEFINE TABLE IF NOT EXISTS next_step TYPE RELATION IN process_step OUT process_step SCHEMAFULL;
DEFINE TABLE IF NOT EXISTS processed_on TYPE RELATION IN lot OUT equipment SCHEMAFULL;
DEFINE TABLE IF NOT EXISTS raised TYPE RELATION IN equipment OUT alarm SCHEMAFULL;




