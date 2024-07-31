table 50130 "User Posting Template"
{
    fields
    {
        field(1; UserID; Code[50])
        {
            TableRelation = "User Setup";
        }
        field(2; "Receipt Journal Template"; Code[10])
        {
            TableRelation = "Gen. Journal Template".Name WHERE(Type=CONST("Cash Receipts"));
        }
        field(3; "Receipt Journal Batch"; Code[10])
        {
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name"=FIELD("Receipt Journal Template"));
        }
        field(4; "Payment Journal Template"; Code[10])
        {
            TableRelation = "Gen. Journal Template".Name WHERE(Type=CONST(Payments));
        }
        field(5; "Payment Journal Batch"; Code[10])
        {
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name"=FIELD("Payment Journal Template"));
        }
        field(6; "Petty Cash Journal Template"; Code[10])
        {
            TableRelation = "Gen. Journal Template".Name WHERE(Type=CONST(Payments));
        }
        field(7; "Petty Cash Journal Batch"; Code[10])
        {
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name"=FIELD("Petty Cash Journal Template"));
        }
        field(8; "Bank Trans. Journal Template"; Code[10])
        {
            TableRelation = "Gen. Journal Template".Name WHERE(Type=CONST(General));
        }
        field(9; "Bank Trans. Journal Batch"; Code[10])
        {
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name"=FIELD("Bank Trans. Journal Template"));
        }
        field(10; "Item Journal Template"; Code[10])
        {
            TableRelation = "Item Journal Template";
        }
        field(11; "Item Journal Batch"; Code[10])
        {
            TableRelation = "Item Journal Batch".Name WHERE("Journal Template Name"=FIELD("Item Journal Template"));
        }
        field(12; "Payroll Journal Template"; Code[10])
        {
            TableRelation = "Gen. Journal Template".Name WHERE(Type=CONST(General));
        }
        field(13; "Payroll Journal Batch"; Code[10])
        {
            TableRelation = "Gen. Journal Batch".Name WHERE("Journal Template Name"=FIELD("Payroll Journal Template"));
        }
        field(14; "Job Journal Template"; Code[10])
        {
            TableRelation = "Job Journal Template".Name;
        }
        field(15; "Job Journal Batch"; Code[10])
        {
            TableRelation = "Job Journal Batch".Name WHERE("Journal Template Name"=FIELD("Job Journal Template"));
        }
    }
    keys
    {
        key(Key1; UserID)
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
}
