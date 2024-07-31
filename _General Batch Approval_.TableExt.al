tableextension 50138 "General Batch Approval" extends "Gen. Journal Batch"
{
    fields
    {
        field(50000; Status; Option)
        {
            OptionMembers = Open, "Pending Approval", Approved;
            DataClassification = ToBeClassified;
            ObsoleteState = Removed;
        }
        field(50001; "Payroll period"; code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(50002; "Payroll start date"; Date)
        {
            DataClassification = ToBeClassified;
        }
    }
    var myInt: Integer;
}
