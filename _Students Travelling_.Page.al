page 50507 "Students Travelling"
{
    PageType = ListPart;
    SourceTable = "Students Travelling";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field("Request No"; Rec."Request No")
                {
                    Visible = false;
                }
                field("Student No"; Rec."Student No")
                {
                }
                field("Student Name"; Rec."Student Name")
                {
                    Editable = false;
                }
                field("Student Programme"; Rec."Student Programme")
                {
                    Editable = false;
                }
            }
        }
    }
    actions
    {
        area(processing)
        {
            action("Sugest Students")
            {
                Image = CustomerList;

                trigger OnAction()
                begin
                    GetStudents(Rec."Request No");
                end;
            }
            action("Import Students")
            {
                Ellipsis = true;
                Image = Import;

                trigger OnAction()
                begin
                    // CLEAR(ImportStudents);
                    // ImportStudents.GetReqNo(Rec);
                    // ImportStudents.RUN;
                end;
            }
        }
    }
    procedure GetStudents(RequestNo: Code[30])
    var
        Customer: Record Customer;
        Students: Record "Students Travelling";
        FilterStudents: FilterPageBuilder;
    begin
        // WITH FilterStudents DO
        //  BEGIN
        //    CLEAR(FilterStudents);
        //    ADDTABLE(Customer.TABLENAME, DATABASE::Customer);
        //    //ADDFIELD(Customer.TABLENAME,Customer."Cleared Programme");
        //    //ADDFIELD(Customer.TABLENAME,Customer.Status::Current);
        //    //ADDFIELD(Customer.TABLENAME,Customer."Current Student Stage");
        //    //ADDFIELD(Customer.TABLENAME,Customer."Current Student Semester");
        //    IF NOT RUNMODAL THEN EXIT;
        //    Customer.SETVIEW(GETVIEW(Customer.TABLENAME));
        //    IF Customer.FINDSET THEN
        //      REPEAT
        //        Students.INIT;
        //        Students."Request No":=RequestNo;
        //        Students."Student No":=Customer."No.";
        //        Students."Student Name":=Customer.Name;
        //        //Students."Student Programme":=Customer."Cleared Programme";
        //        Students.INSERT;
        //      UNTIL Customer.NEXT=0;
        //  END;
    end;
}
