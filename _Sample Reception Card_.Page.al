page 50968 "Sample Reception Card"
{
    Caption = 'Sample Reception Card';
    PageType = Card;
    SourceTable = "Sample Reception Header";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            group(General)
            {
                Editable = not Rec."Sent to Lab";

                field("Entry No."; Rec."Entry No.")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Entry Officer No."; Rec."Entry Officer No.")
                {
                    Enabled = false;
                }
                field("Entry officer"; Rec."Entry officer")
                {
                    ApplicationArea = All;
                    Enabled = false;
                }
                field("Sample Type"; Rec."Sample Type")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        CurrPage.Update();
                    end;
                }
                group(Schedule)
                {
                    Visible = ScheduleVisible;
                    ShowCaption = false;

                    field("Schedule No."; Rec."Schedule No.")
                    {
                        ApplicationArea = All;

                        trigger OnValidate()
                        begin
                            CurrPage.Update();
                        end;
                    }
                    field("Cluster Option"; Rec."Cluster Option")
                    {
                        ApplicationArea = All;
                    }
                }
                group(ClientDetails)
                {
                    Visible = ClientVisible;
                    ShowCaption = false;

                    field(Client; Rec.Client)
                    {
                        ApplicationArea = All;
                    }
                    field("Client Name"; Rec."Client Name")
                    {
                        ApplicationArea = All;
                    }
                }
                group("Cluster Details")
                {
                    ShowCaption = false;
                    Visible = clustered;

                    field(Cluster; Rec.Cluster)
                    {
                        ApplicationArea = All;
                    }
                }
                // field("Lab section to test"; Rec."Lab section to test")
                // {
                //     ApplicationArea = All;
                // }
                field(Date; Rec.Date)
                {
                    ApplicationArea = All;
                }
                field(Time; Rec."Testing Time")
                {
                    ApplicationArea = All;
                }
                group(BranchVisible)
                {
                    ShowCaption = false;
                    Visible = not clustered;

                    field(Branch; Rec.Branch)
                    {
                        ApplicationArea = All;
                    }
                }
                field("Name of Sampled Outlet"; Rec."Name of Sampled Outlet")
                {
                    ApplicationArea = All;
                }
                field("Sampling Date"; Rec."Sampling Date")
                {
                    ApplicationArea = All;
                }
                field("Sample Name"; Rec."Sample Name")
                {
                    ApplicationArea = All;
                }
                field(SampleID; Rec.SampleID)
                {
                    ApplicationArea = All;
                }
                field("Entry Type"; Rec."Entry Type")
                {
                    ApplicationArea = All;
                }
                field("KDB License number"; Rec."KDB License number")
                {
                    Caption = 'Permit No.';
                    ApplicationArea = All;
                }
                field("Sample Category"; Rec."Sample Category")
                {
                    Caption = 'Test Category';
                    ApplicationArea = All;
                }
                field("Sample Source"; Rec."Sample Source")
                {
                    Caption = 'Outlet Category';
                    ApplicationArea = All;
                }
                field(Description; DescriptionTxt)
                {
                    caption = 'Product Source';
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        Rec.CalcFields(Description);
                        rec.Description.CreateInStream(InStrm);
                        DescriptionBigTxt.Read(InStrm);
                        if DescriptionTxt <> Format(DescriptionBigTxt) then begin
                            Clear(Rec.Description);
                            Clear(DescriptionBigTxt);
                            DescriptionBigTxt.AddText(DescriptionTxt);
                            rec.Description.CreateOutStream(OutStrm);
                            DescriptionBigTxt.Write(OutStrm);
                        end;
                    end;
                }
                field(Quantity; Rec.Quantity)
                {
                    Caption = 'Sample Quantity';
                    ApplicationArea = All;
                }
                field("Batch Quantity"; Rec."Batch Quantity")
                {
                    ApplicationArea = All;
                }
                field("Unit of Measure"; Rec."Unit of Measure")
                {
                }
                label("Delivered By:")
                {
                    Style = Strong;
                }
                group(Officer)
                {
                    ShowCaption = false;
                    Visible = ScheduleVisible;

                    field("Sampling officer No."; Rec."Sampling officer No.")
                    {
                        ApplicationArea = all;
                    }
                    field("Sampling officer"; Rec."Sampling officer")
                    {
                        ApplicationArea = All;
                        Editable = false;
                    }
                }
                group(Batch)
                {
                    ShowCaption = false;
                    visible = BatchNo;

                    field("Batch No."; Rec."Batch No.")
                    {
                        ApplicationArea = All;
                    }
                }
                group(Expiry)
                {
                    ShowCaption = false;
                    visible = ExpiryDate;

                    field("Manufacture Date"; Rec."Manufacture Date")
                    {
                        ApplicationArea = All;
                    }
                    field("Expiry Date"; Rec."Expiry Date")
                    {
                    }
                }
                group(AreaDetails)
                {
                    Visible = not clustered;

                    field(County; Rec.County)
                    {
                        ApplicationArea = All;
                    }
                    field("County Name"; Rec."County Name")
                    {
                        ApplicationArea = All;
                        Enabled = false;
                    }
                    field(Subcounty; Rec.Subcounty)
                    {
                        ApplicationArea = All;
                    }
                    field("Sub-County Name"; Rec."Sub-County Name")
                    {
                        ApplicationArea = All;
                        Enabled = false;
                    }
                    field(Location; Rec.Location)
                    {
                        ApplicationArea = All;
                    }
                    field(Market; Rec.Market)
                    {
                        ApplicationArea = All;
                    }
                }
            }
            part("Sample Branches"; "Sample Branches")
            {
                Caption = 'Sample Brand';
                SubPageLink = "No." = field("Entry No."), "Customer No" = field(Client);
                UpdatePropagation = Both;
                ApplicationArea = All;
            }
            part(Conditions; "Sample Conditions Lines")
            {
                SubPageLink = "Entry No." = field("Entry No.");
                UpdatePropagation = Both;
                ApplicationArea = All;
            }
            group(Retention)
            {
                field("Retention Required"; Rec."Retention Required")
                {
                    ApplicationArea = All;

                    trigger OnValidate()
                    begin
                        SetControlAppearance;
                        CurrPage.Update();
                    end;
                }
                group(DisposalDate)
                {
                    Visible = Retention;

                    field("Sample Retention Period"; Rec."Sample Retention Period")
                    {
                    }
                    field("Sample Disposal Date"; Rec."Sample Disposal Date")
                    {
                    }
                }
                part(Retentions; "Sample Ret Condition Lines")
                {
                    Visible = Retention;
                    SubPageLink = "Entry No." = field("Entry No.");
                    ApplicationArea = All;
                    UpdatePropagation = Both;
                }
            }
            part("Sample targeted tests"; "Sample targeted tests")
            {
                SubPageLink = "Entry No." = field("Entry No."); //, "Sample ID" = field(SampleID);
                ApplicationArea = All;
            }
        }
    }
    actions
    {
        area(Processing)
        {
            action("Sent for transmission")
            {
                Visible = not Rec."Sent to Lab";
                Image = SendMail;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                ApplicationArea = All;

                trigger OnAction()
                var
                    TestLines: Record "Sample Test Lines";
                begin
                    if BatchNo = true then Rec.TestField("Batch No.");
                    if ExpiryDate = true then begin
                        Rec.TestField("Expiry Date");
                    end;
                    if ManufacturingDate = true then begin
                        Rec.TestField("Manufacture Date");
                    end;
                    TestLines.Reset();
                    TestLines.SetRange("Entry No.", Rec."Entry No.");
                    TestLines.SetFilter("Sample Name", '<>%1', '');
                    if TestLines.Find() then
                        repeat
                            TestLines.TestField(Lab);
                            TestLines.TestField(Test);
                        until TestLines.Next() = 0;
                    Rec.MarkAnnualSchedule();
                    LabManagement.TransferSampleToAnalysis(Rec);
                    Message('Sample sent to lab successfully');
                    CurrPage.Close();
                end;
            }
        }
    }
    trigger OnAfterGetRecord()
    begin
        SetControlAppearance;
        Rec.CalcFields(Description);
        rec.Description.CreateInStream(InStrm);
        DescriptionBigTxt.Read(InStrm);
        DescriptionTxt := Format(DescriptionBigTxt);
    end;

    trigger OnOpenPage()
    begin
        SetControlAppearance;
    end;

    var
        LabManagement: Codeunit "Laboratory Management";
        InStrm: InStream;
        OutStrm: OutStream;
        DescriptionBigTxt: BigText;
        DescriptionTxt: Text;
        ClientVisible: Boolean;
        ScheduleVisible: Boolean;
        Retention: Boolean;
        ExpiryDate: Boolean;
        ManufacturingDate: Boolean;
        BatchNo: Boolean;
        Explanation: Boolean;
        clustered: Boolean;
        Conditions: Record "Sample Conditions Line";

    local procedure SetControlAppearance()
    begin
        if Rec."Sample Type" = Rec."Sample Type"::"From Schedule" then
            ScheduleVisible := true
        else
            ScheduleVisible := false;
        if Rec."Sample Type" = Rec."Sample Type"::Client then
            ClientVisible := true
        else
            ClientVisible := false;
        if Rec."Retention Required" = Rec."Retention Required"::Yes then
            Retention := true
        else
            Retention := false;
        Conditions.Reset();
        Conditions.SetRange("Entry No.", Rec."Entry No.");
        Conditions.CalcFields("Expiry date needed", "Batch Number needed");
        Conditions.SetRange("Expiry date needed", true);
        if Conditions.FindFirst() then
            ExpiryDate := true
        else
            ExpiryDate := false;
        Conditions.Reset();
        Conditions.SetRange("Entry No.", Rec."Entry No.");
        Conditions.CalcFields("Manufacturing date needed");
        Conditions.SetRange("Manufacturing date needed", true);
        if Conditions.FindFirst() then
            ManufacturingDate := true
        else
            ManufacturingDate := false;
        if Rec."Cluster Option" = Rec."Cluster Option"::Cluster then
            clustered := true
        else
            clustered := false;
        Conditions.Reset();
        Conditions.SetRange("Entry No.", Rec."Entry No.");
        Conditions.CalcFields("Expiry date needed", "Batch Number needed");
        Conditions.SetRange("Batch Number needed", true);
        if Conditions.FindFirst() then
            BatchNo := true
        else
            BatchNo := false;
    end;
}
