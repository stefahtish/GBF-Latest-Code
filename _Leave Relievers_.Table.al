table 50300 "Leave Relievers"
{
    fields
    {
        field(1; "Leave Code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(2; "Staff No"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee."No." where("Employment Status"=CONST(Active), "Status"=CONST(Active));

            trigger OnValidate()
            begin
                LeaveApp.Get("Leave Code");
                if "Staff No" = LeaveApp."Employee No" then Error('You can not be your own reliever!');
                if Employee.Get("Staff No")then "Staff Name":=Employee."First Name" + ' ' + Employee."Middle Name" + ' ' + Employee."Last Name";
            end;
        }
        field(3; "Staff Name"; Text[100])
        {
            DataClassification = ToBeClassified;
        //Editable = false;
        }
    }
    keys
    {
        key(Key1; "Leave Code", "Staff No")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    var Employee: Record Employee;
    LeaveApp: Record "Leave Application";
}
