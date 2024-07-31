table 50239 "Travel Requests"
{
    DrillDownPageId = "Transport Request";
    LookupPageId = "Transport Request";

    fields
    {
        field(1; "Request No."; Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(2; "Request Date"; Date)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(3; "Request ID"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(4; "Employee No."; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Employee;

            trigger OnValidate()
            begin
            /*
                IF Empl.GET("Employee No.") THEN
                  BEGIN
                    "Employee Name":=Empl."First Name"+' '+Empl."Middle Name"+' '+Empl."Last Name";
                    "Employee Type":=Empl."Nature of Employment";
                
                  END;
                  */
            end;
        }
        field(5; "Employee Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(6; "Trip Planned Start Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                begin
                    if "Trip Planned Start Date" < Today then Error('Planned start date cannot be earlier than today');
                end;
            end;
        }
        field(7; "Trip Planned End Date"; Date)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                begin
                    if "Trip Planned End Date" < Today then Error('Planned end date cannot be earlier than today');
                    if "Trip Planned End Date" < "Trip Planned Start Date" then Error('Planned end date cannot be earlier than planned start date');
                end;
            end;
        }
        field(8; Destinations; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(9; "Geographical Terrain"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(10; "No. of Personnel"; Integer)
        {
            CalcFormula = Count("Travelling Employee" WHERE("Request No."=FIELD("Request No.")));
            FieldClass = FlowField;
        }
        field(11; "Predicted Weather Conditions"; Text[30])
        {
            DataClassification = ToBeClassified;
        }
        field(12; "Vehicle Allocated"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "Fixed Asset" WHERE("FA Class Code"=CONST('MV'));

            trigger OnValidate()
            begin
                if FA.Get("Vehicle Allocated")then begin
                    "Vehicle Description":=FA.Description;
                end;
                FA.TestField("Responsible Employee");
                Empl.SetRange("No.", FA."Responsible Employee");
                if Empl.Find('-')then begin
                    Driver:=Empl."No.";
                    "Driver Name":=Empl."First Name" + ' ' + Empl."Middle Name" + ' ' + Empl."Last Name";
                end;
            /*
                IF Status<>Status::Released THEN
                ERROR('You are not allowed to assign a vehicle when the transport request has not been approved');


                 {
                      IF FA.GET("Vehicle Allocated") THEN
                   BEGIN
                   "Vehicle Description":=FA.Description;
                  // "Vehicle Allocated":="Vehicle Description";
                   FA.CALCFIELDS(FA."In Use");
                   IF FA."In Use" THEN
                   ERROR('This vehicle is currently un-available');
                   END;
                  }
               */
            end;
        }
        field(13; "Outsourced Vehicle Reg No."; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(14; "Vehicle Owner"; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Vendor;
        }
        field(15; "Odometer Reading Before"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Distance Travelled":=("Odometer Reading After" - "Odometer Reading Before");
            /*
                Mantainance.RESET;
                 Mantainance.SETRANGE(Mantainance."Item No.","Vehicle Allocated");
                 IF Mantainance.FIND('+') THEN BEGIN
                    IF "Odometer Reading Before">=(Mantainance."Current Odometer Reading"+Mantainance."Service Mileage") THEN BEGIN
                          CompanyInfo.GET();
                      Recipients:=CompanyInfo."Fleet Manager Support Email";
                      CompanyInfo.GET();
                      SenderName:=COMPANYNAME;
                      SenderAddress:=CompanyInfo."E-Mail";
                      Subject:='Vehicle Mantainace '+"Vehicle Allocated";
                      Body:=STRSUBSTNO('This is to notify you that the Vehicle No. %1 is due for servicing',"Vehicle Allocated");
                      SMTPSetup.CreateMessage(SenderName,SenderAddress,Recipients,Subject,Body,TRUE);
                      SMTPSetup.Send;
                
                    END;
                 END;
                */
            end;
        }
        field(16; "Odometer Reading After"; Decimal)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                "Distance Travelled":=("Odometer Reading After" - "Odometer Reading Before");
            /*
                Mantainance.RESET;
                Mantainance.SETRANGE(Mantainance."Item No.","Vehicle Allocated");
                IF Mantainance.FIND('+') THEN BEGIN
                   IF "Odometer Reading Before">=(Mantainance."Current Odometer Reading"+Mantainance."Service Mileage") THEN BEGIN
                         CompanyInfo.GET();
                     Recipients:=CompanyInfo."Fleet Manager Support Email";
                     CompanyInfo.GET();
                     SenderName:=COMPANYNAME;
                     SenderAddress:=CompanyInfo."E-Mail";
                     Subject:='Vehicle Mantainace '+"Vehicle Allocated";
                     Body:=STRSUBSTNO('This is to notify you that the Vehicle No. %1 is due for servicing',"Vehicle Allocated");
                     SMTPSetup.CreateMessage(SenderName,SenderAddress,Recipients,Subject,Body,TRUE);
                     SMTPSetup.Send;

                   END;
               END
               */
            end;
        }
        field(17; "No. Series"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = "No. Series";
        }
        field(18; Country; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(19; "Town/City"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(20; Status; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Open,Approved,Pending Approval,Pending Prepayment,Rejected';
            OptionMembers = Open, Released, "Pending Approval", "Pending Prepayment", Rejected;
        }
        field(21; "No. of Approvals"; Integer)
        {
            CalcFormula = Count("Approval Entry" WHERE("Table ID"=CONST(50239), "Document No."=FIELD("Request No.")));
            FieldClass = FlowField;
        }
        field(22; "Reason for Travel"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(23; "Start Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(24; "Return Date"; Date)
        {
            DataClassification = ToBeClassified;
        }
        field(25; "Start Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(26; "Return Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(27; "Vehicle Description"; Text[80])
        {
            DataClassification = ToBeClassified;
        }
        field(28; "User ID"; Code[30])
        {
            DataClassification = ToBeClassified;
            TableRelation = "User Setup";
        }
        field(29; "Travel Details"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(30; Driver; Code[20])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            /*
                 IF Status<>Status::Released THEN
                 ERROR('You are not allowed to assign a driver when the transport request has not been approved');
                
                 IF Empl.GET(Driver) THEN
                // BEGIN
                 "Driver Name":=Empl."First Name"+' '+Empl."Middle Name"+' '+Empl."Last Name";
                
                 TESTFIELD("Vehicle Allocated");
                
                TravellingEmployees.RESET;
                TravellingEmployees.SETRANGE(TravellingEmployees."Request No.","Request No.");
                IF TravellingEmployees.FIND('-') THEN
                BEGIN
                 REPEAT
                 UserSetup.RESET;
                 UserSetup.SETRANGE(UserSetup."Employee No.",TravellingEmployees."Employee No.");
                 IF UserSetup.FIND('-') THEN
                 BEGIN
                   UserSetup.TESTFIELD(UserSetup."E-Mail");
                  Recipients:=UserSetup."E-Mail";
                
                  CompanyInfo.GET();
                  SenderName:=COMPANYNAME;
                  SenderAddress:=CompanyInfo."Fleet Manager Support Email";
                
                  Subject:='Vehicle Allocation for Transport Request '+"Request No.";
                  Body:='This is to inform you that you have been allocated Vehicle No '+"Vehicle Allocated"+', '+"Vehicle Description"+' and Driver '+"Driver Name"+' for the trip to '+Destination;
                  SMTPSetup.CreateMessage(SenderName,SenderAddress,Recipients,Subject,Body,TRUE);
                  SMTPSetup.Send;
                  END;
                 UNTIL TravellingEmployees.NEXT=0;
                END;
                */
            end;
        }
        field(31; "Driver Name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(32; "No of Cars"; Option)
        {
            DataClassification = ToBeClassified;
            OptionMembers = Taxi, "Company Car";
        }
        field(33; Cancelled; Boolean)
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            /*
                         IF Cancelled=TRUE THEN  BEGIN
               MESSAGE('The trip request is been cancelled');
                   ToName:='';
                   CName:='';

               Subject:='Your vehicle request has been cancelled ';
               Body:='You vehicle Request has been cancelled';
               UserSetup.GET("User ID");
               ToName:=UserSetup."E-Mail";
               //CCName:='navadmin@erc.go.ke';
               MailSent := Mail.NewMessage(ToName,CName,Subject,Body,'',FALSE);
               IF MailSent THEN
               // MailSent:=Mail.Send()
               MESSAGE('The trip request has been cancelled')
                ELSE
                   MailSent := Mail.Send();

                          END;
                         IF Cancelled=FALSE THEN  BEGIN
                         MESSAGE('You are about to revert the cancelled trip?');
                          END;
               */
            end;
        }
        field(34; "No. of Non Employees"; Integer)
        {
            CalcFormula = Count("Travelling Non Employees" WHERE("Request No."=FIELD("Request No.")));
            FieldClass = FlowField;
            TableRelation = "Travelling Non Employees";
        }
        field(35; "Shortcut Dimension 1"; Code[30])
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(36; "Department Name"; Text[50])
        {
            Editable = false;
            FieldClass = Normal;
        }
        field(37; "No. of Students"; Integer)
        {
            CalcFormula = Count("Students Travelling" WHERE("Request No"=FIELD("Request No.")));
            Editable = false;
            FieldClass = FlowField;
            TableRelation = "Dimension Value".Code;
        }
        field(38; "Directorate name"; Text[50])
        {
            DataClassification = ToBeClassified;
        }
        field(39; "Fuel Consumed"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(40; "Number of Passengers"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(41; "Distance Travelled"; Decimal)
        {
            DataClassification = ToBeClassified;
            Editable = false;
        }
        field(42; "Estimated Fuel Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(43; "Estimated Mileage/Mantain-Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(44; "Travel Cost"; Decimal)
        {
            DataClassification = ToBeClassified;
        }
        field(45; "Request Type"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Travel,Event';
            OptionMembers = Travel, Eplan;
        }
        field(46; "Event No"; Code[10])
        {
            DataClassification = ToBeClassified;
        }
        field(47; "Event Description"; Text[250])
        {
            DataClassification = ToBeClassified;
        }
        field(48; "Global Dimension 4 code"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(49; "Language Code"; Code[10])
        {
            DataClassification = ToBeClassified;
            TableRelation = Language;
        }
        field(50; "Employees Attending"; Integer)
        {
            CalcFormula = Count("Travelling Employee" WHERE("Request No."=FIELD("Request No.")));
            FieldClass = FlowField;
            TableRelation = "Travelling Employee";
        }
        field(51; "Other Participants Attending"; Integer)
        {
            DataClassification = ToBeClassified;
        }
        field(52; "Employee Type"; Code[20])
        {
            DataClassification = ToBeClassified;
        }
        field(53; "Shortcut Dimension 2"; Code[30])
        {
            DataClassification = ToBeClassified;
        }
        field(54; Department; Code[30])
        {
            //CaptionClass = '1,2,2';
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
                Dim.Reset;
                Dim.SetRange(Code, "Shortcut Dimension 2 Code");
                if Dim.Find('-')then begin
                    "Department Name":=Dim.Name;
                end;
            end;
        //TableRelation = "Dimension Value".Code;
        }
        field(55; "No of Vehicles"; Integer)
        {
            CalcFormula = Count("Transport Trips" WHERE("Request No"=FIELD("Request No.")));
            Editable = false;
            FieldClass = FlowField;
        }
        field(56; Destination; Code[20])
        {
            DataClassification = ToBeClassified;
            TableRelation = Destination;
        }
        field(50000; "Total Approved Amount"; Decimal)
        {
            FieldClass = Normal;
        }
        field(50001; "Total Amount Requested"; Decimal)
        {
            FieldClass = Normal;
        }
        field(50002; "Event Code"; Code[10])
        {
            DataClassification = ToBeClassified;

            trigger OnValidate()
            begin
            /*
                DimensionValue.RESET;
                DimensionValue.SETRANGE(DimensionValue.Code,"Event Code");
                IF DimensionValue.FIND('-')THEN
                "Event Description":=DimensionValue.Name;
                */
            end;
        }
        field(50003; "Shortcut Dimension 1 Code"; Code[30])
        {
            CaptionClass = '1,2,1';
            Caption = 'Shortcut Dimension 1 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(1));

            //Blocked = FILTER(false));
            trigger OnValidate()
            var
                Transporttrips: Record "Transport Trips";
                FixedAsset: Record "Fixed Asset";
                Dimensionvalues: Record "Dimension Value";
                Emp: Record Employee;
            begin
                ValidateShortcutDimCode(1, "Shortcut Dimension 1 Code");
                Dimensionvalues.Reset();
                Dimensionvalues.SetRange(Code, "Shortcut Dimension 1 Code");
                Dimensionvalues.SetRange(HQ, false);
                if Dimensionvalues.FindFirst()then begin
                    FixedAsset.Reset();
                    FixedAsset.SetRange("Fixed Asset Type", FixedAsset."Fixed Asset Type"::Fleet);
                    FixedAsset.SetRange("Vehicle Type", FixedAsset."Vehicle Type"::Company);
                    FixedAsset.SetRange("Global Dimension 1 Code", "Shortcut Dimension 1 Code");
                    if FixedAsset.FindFirst()then begin
                        Transporttrips.Reset();
                        Transporttrips.SetRange("Request No", "Request No.");
                        if Transporttrips.Find('-')then Transporttrips.DeleteAll();
                        Transporttrips.Reset();
                        Transporttrips.Init();
                        Transporttrips."Request No":="Request No.";
                        Transporttrips."Vehicle No":=FixedAsset."No.";
                        Transporttrips."Vehicle Description":=FixedAsset."Registration No";
                        Transporttrips."Vehicle Type":=FixedAsset."Vehicle Type";
                        Transporttrips.Driver:=FixedAsset."Responsible Employee";
                        if Emp.Get(Transporttrips.Driver)then Transporttrips."Drivers Name":=Emp."First Name" + ' ' + Emp."Middle Name" + ' ' + Emp."Last Name";
                        Transporttrips.Insert();
                    end;
                end;
            end;
        }
        field(50004; "Shortcut Dimension 2 Code"; Code[30])
        {
            CaptionClass = '1,2,2';
            Caption = 'Shortcut Dimension 2 Code';
            DataClassification = ToBeClassified;
            TableRelation = "Dimension Value".Code WHERE("Global Dimension No."=CONST(2), Blocked=FILTER(false));

            trigger OnValidate()
            begin
                Dim.Reset;
                Dim.SetRange(Code, "Shortcut Dimension 2 Code");
                if Dim.Find('-')then "Department Name":=Dim.Name;
                ValidateShortcutDimCode(2, "Shortcut Dimension 2 Code");
            end;
        }
        field(50005; "Request Time"; Time)
        {
            DataClassification = ToBeClassified;
        }
        field(50006; "Transport Status"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = 'Requisition,On Trip,Completed';
            OptionMembers = Requisition, "On Trip", Completed;
        }
        field(50007; "Mode of Travel"; Option)
        {
            DataClassification = ToBeClassified;
            OptionCaption = ' ,Road,Air,Train,Sea';
            OptionMembers = " ", Road, Air, Train, Sea;
        }
        field(50008; Notified; Boolean)
        {
            DataClassification = ToBeClassified;
        }
    }
    keys
    {
        key(Key1; "Request No.")
        {
            Clustered = true;
        }
    }
    fieldgroups
    {
    }
    trigger OnInsert()
    begin
        if "Request No." = '' then begin
            HRSetup.Get;
            HRSetup.TestField("Transport Request Nos.");
            NoSeriesMgt.InitSeries(HRSetup."Transport Request Nos.", xRec."No. Series", 0D, "Request No.", "No. Series");
        end;
        "Request Date":=Today;
        "Request Time":=Time;
        "User ID":=UserId;
        if UserSetup.Get("User ID")then begin
            if Empl.Get(UserSetup."Employee No.")then begin
                "Employee No.":=Empl."No.";
                "Employee Name":=Empl."First Name" + ' ' + Empl."Middle Name" + ' ' + Empl."Last Name";
                "Shortcut Dimension 1 Code":=Empl."Global Dimension 1 Code";
                Validate("Shortcut Dimension 1 Code");
                Department:=Empl."Global Dimension 1 Code";
                Validate(Department);
                "Shortcut Dimension 2 Code":=Empl."Global Dimension 2 Code";
                Validate("Shortcut Dimension 2 Code");
            end;
        end;
    end;
    var HRSetup: Record "Human Resources Setup";
    NoSeriesMgt: Codeunit NoSeriesManagement;
    UserSetup: Record "User Setup";
    Empl: Record Employee;
    FA: Record "Fixed Asset";
    Transport: Record "Travelling Employee";
    Dim: Record "Dimension Value";
    DimMgt: Codeunit DimensionManagement;
    local procedure ValidateShortcutDimCode(FieldNumber: Integer; var ShortcutDimCode: Code[20])
    begin
        DimMgt.ValidateDimValueCode(FieldNumber, ShortcutDimCode);
    // DimMgt.SaveDefaultDim(DATABASE::"Travel Requests","Employee No.",FieldNumber,ShortcutDimCode);
    // MODIFY;
    end;
}
