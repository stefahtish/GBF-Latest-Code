page 51081 "Phosphatase Test Form"
{
    Caption = 'Phosphatase Test Form';
    PageType = ListPart;
    SourceTable = "Sample Test";
    ApplicationArea = All;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                //Phosphatase
                field("Color Indication"; Rec."Color Indication")
                {
                    Visible = ColorIndication;
                    ApplicationArea = All;
                }
                // field("Results Rapid test (mg/L)"; Rec."Results Rapid test (mg/L)")
                // {
                //     Visible = Rapidtest;
                //     ApplicationArea = All;
                // }
                // field("Flow time in seconds"; Rec."Flow time in seconds")
                // {
                //     Visible = FlowTime;
                // }
                // field(Colour; Rec.Colour)
                // {
                //     Visible = Color;
                //     ApplicationArea = All;
                // }
                // field("Odour and Taints "; Rec."Odour and Taints ")
                // {
                //     Visible = Odour;
                //     ApplicationArea = All;
                // }
                // field("Titer (ml)"; Rec."Titer (ml)")
                // {
                //     ApplicationArea = All;
                //     Visible = TiterML;
                //     trigger OnValidate()
                //     var
                //         myInt: Integer;
                //     begin
                //         if "Titer (ml)" <> 0 then begin
                //             "Constant (0.282)" := 0.282;
                //             Results := format("Titer (ml)" * "Constant (0.282)");
                //         end;
                //     end;
                // }
                // field("Constant (0.282)"; Rec."Constant (0.282)")
                // {
                //     ApplicationArea = All;
                //     Visible = Constant282;
                // }
                // field(Results; Rec.Results)
                // {
                //     Caption = 'Free fatty acid content in %(titer x 0.282)';
                //     ApplicationArea = All;
                //     Visible = ResultsVisible;
                // }
                field(Specifications; Rec.Specifications)
                {
                    Visible = SpecificationsVisible;
                    ApplicationArea = All;
                }
                field("Interpretation(Pasteurized)"; Rec."Interpretation(Pasteurized)")
                {
                    Visible = InterpretationPasteurized;
                    ApplicationArea = All;
                }
                // //Milk              
                // field("Interpretation(Preserved)"; Rec."Interpretation(Preserved)")
                // {
                //     Visible = InterpretationPreserved;
                //     ApplicationArea = All;
                // }
                // //butterfat
                // field("Butter Fat content (%)"; Rec."Butter Fat content (%)")
                // {
                //     Visible = ButterFat;
                //     ApplicationArea = All;
                // }
                // field("Specification (%)"; Rec."Specification (%)")
                // {
                //     Visible = SpecificationPerc;
                //     ApplicationArea = All;
                // }
                // //Preliminary
                // field("Alcohol Test Results"; Rec."Alcohol Test Results")
                // {
                //     Visible = MyCobacterium;
                //     ApplicationArea = All;
                // }
                // field("Alcohol Test Specifications"; Rec."Alcohol Test Specifications")
                // {
                //     Visible = MyCobacterium;
                //     ApplicationArea = All;
                // }
                // field("Resazurin test results"; Rec."Resazurin test results")
                // {
                //     Visible = MyCobacterium;
                //     ApplicationArea = All;
                // }
                // field("Resazurin Test Specifications"; Rec."Resazurin Test Specifications")
                // {
                //     Visible = MyCobacterium;
                //     ApplicationArea = All;
                // }
                // field(Sulfonamide; Rec.Sulfonamide)
                // {
                //     Visible = Antibiotics;
                //     ApplicationArea = All;
                // }
                // field("Beta-Lactam"; Rec."Beta-Lactam")
                // {
                //     Visible = Antibiotics;
                //     ApplicationArea = All;
                // }
                // field(Tetracycline; Rec.Tetracycline)
                // {
                //     Visible = Antibiotics;
                //     ApplicationArea = All;
                // }
                // field("Results in g/ml"; Rec."Results in g/ml")
                // {
                //     Visible = ResultsGML;
                //     ApplicationArea = All;
                // }
                // field("Brix content (g/ml)"; Rec."Brix content (g/ml)")
                // {
                //     Caption = 'Sucrose content (g/ml)';
                //     ApplicationArea = All;
                // }
                // field("Specifications g/ml"; "Specifications g/ml")
                // {
                //     Visible = SpecificationGMl;
                //     ApplicationArea = All;
                // }
                field("Remarks(PassFail)"; Rec."Remarks(PassFail)")
                {
                    Visible = RemarksPassFail;
                    ApplicationArea = All;
                }
                field("Cannot be done"; Rec."Cannot be done")
                {
                    ApplicationArea = All;
                }
                field(Comment; Rec.Comment)
                {
                    ApplicationArea = All;
                }
            }
        }
    }
    var
        SampleRecHeader: Record "Sample Test Header";
        InterpretationPasteurized: Boolean;
        InterpretationPreserved: Boolean;
        SpecificationsVisible: Boolean;
        ColorIndication: Boolean;
        Rapidtest: Boolean;
        ButterFat: Boolean;
        SpecificationPerc: Boolean;
        SpecificationGMl: Boolean;
        RemarksPassFail: Boolean;
        MyCobacterium: Boolean;
        Antibiotics: Boolean;
        FlowTime: Boolean;
        ResultsGML: Boolean;
        Brix: Boolean;
        Color: Boolean;
        Odour: Boolean;
        TiterML: Boolean;
        Constant282: Boolean;
        ResultsVisible: Boolean;

    procedure SetControlAppearance2(SampleRecHeader: Record "Sample Test Header")
    begin
        if (SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Phosphatase test") or (SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Milk preservation test") or (SampleRecHeader.TestForm = SampleRecHeader.TestForm::Density) or (SampleRecHeader.TestForm = SampleRecHeader.TestForm::Organoleptic) or (SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Free fatty acid") then begin
            SpecificationsVisible := true;
        end;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Phosphatase test" then begin
            InterpretationPasteurized := true
        end;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Phosphatase test" then begin
            ColorIndication := true
        end;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Milk preservation test" then begin
            InterpretationPreserved := true;
        end;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Milk preservation test" then begin
            Rapidtest := true;
        end;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Butter fat" then begin
            ButterFat := true;
        end;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Butter fat" then begin
            SpecificationPerc := true;
        end;
        if (SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Butter fat") or (SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Brix test") or (SampleRecHeader.TestForm = SampleRecHeader.TestForm::Density) or (SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Mycobacterium spp") or (SampleRecHeader.TestForm = SampleRecHeader.TestForm::Density) or (SampleRecHeader.TestForm = SampleRecHeader.TestForm::Organoleptic) or (SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Free fatty acid") then begin
            RemarksPassFail := true;
        end;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Mycobacterium spp" then MyCobacterium := true;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Antibiotic residue" then Antibiotics := true;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::Volume then FlowTime := true;
        if (SampleRecHeader.TestForm = SampleRecHeader.TestForm::Density) or (SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Brix test") then SpecificationGMl := true;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::Density then ResultsGML := true;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Brix test" then Brix := true;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::Organoleptic then begin
            Color := true;
            Odour := true;
        end;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Free fatty acid" then begin
            TiterML := true;
            Constant282 := true;
            ResultsVisible := true;
        end;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Moisture determination" then
            SampleRecHeader.Moisture := true
        else
            SampleRecHeader.Moisture := false;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::Coliforms then
            SampleRecHeader.Coliform := true
        else
            SampleRecHeader.Coliform := false;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Staph.aureaus" then
            SampleRecHeader.StaphAurea := true
        else
            SampleRecHeader.StaphAurea := false;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"E.coli test" then
            SampleRecHeader.Ecoli := true
        else
            SampleRecHeader.Ecoli := false;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Total plate count" then
            SampleRecHeader.TotalViable := true
        else
            SampleRecHeader.TotalViable := false;
        if SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Yeast and molds" then
            SampleRecHeader.YeastMould := true
        else
            SampleRecHeader.YeastMould := false;
        if (SampleRecHeader.TestForm = SampleRecHeader.TestForm::General) then
            SampleRecHeader.Others := true
        else
            SampleRecHeader.Others := false;
        if (SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Peroxide Conventional form") then
            SampleRecHeader.Conventional := true
        else
            SampleRecHeader.Conventional := false;
        if (SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Resazurin Test") then
            SampleRecHeader.Resazurin := true
        else
            SampleRecHeader.Resazurin := false;
        if (SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Moisture analyzer form") then
            SampleRecHeader.MoistureAnalyzer := true
        else
            SampleRecHeader.MoistureAnalyzer := false;
        if (SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Moulds Count") then
            SampleRecHeader.Moulds := true
        else
            SampleRecHeader.Moulds := false;
        if (SampleRecHeader.TestForm = SampleRecHeader.TestForm::"Aflatoxin M1 form") then
            SampleRecHeader.Aflatoxin := true
        else
            SampleRecHeader.Aflatoxin := false;
        SampleRecHeader.Modify();
    end;
}
