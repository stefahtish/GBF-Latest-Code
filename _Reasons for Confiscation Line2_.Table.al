table 50590 "Reasons for Confiscation Line2"
{
    Caption = 'Reasons for Confiscation Lines';
    DataClassification = ToBeClassified;

    fields
    {
        field(1; "No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(2; Code; Code[100])
        {
            Caption = 'Category';
            DataClassification = ToBeClassified;
            TableRelation = "Reasons For Confiscation Setup";
        // trigger OnValidate()
        // var
        //     ReasonsSetup: Record "Reasons For Confiscation Setup";
        // begin
        //     ReasonsSetup.Reset();
        //     ReasonsSetup.SetRange(Code, Code);
        //     if ReasonsSetup.Find('-') then
        //         Description := ReasonsSetup.Description;
        // end;
        }
        field(3; Description; Text[1000])
        {
            Caption = 'Description';
            DataClassification = ToBeClassified;
            TableRelation = ConfiscReasons2.Description where(Code=field(Code));
        }
        field(4; Remarks; Text[1000])
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(PK; "No.", Code)
        {
            Clustered = true;
        }
    }
}
